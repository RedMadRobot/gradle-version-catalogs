#!/usr/bin/env bash
#
# Shared helpers for the update-version-catalog scripts, written for the LOWEST
# common denominator so the same scripts run on macOS and on Windows/Git Bash:
#
#   * bash 3.2 — the version macOS ships (/bin/bash). Therefore NO associative
#     arrays, no ${var,,}, no mapfile/readarray, and `"${arr[@]}"` is expanded
#     only after checking the array is non-empty (bash < 4.4 treats an empty
#     expansion as an unbound variable under `set -u`).
#   * BSD userland — macOS sed/grep/sort/awk. Therefore NEVER `\t`/`\n` in a sed
#     replacement (BSD sed emits a literal t/n), no `\s` in an ERE (use
#     [[:space:]]), no `sort -V` (use vsort/vge below), no GNU-only awk features
#     such as a multi-character RS.
#
# This file is sourced, never executed.

NL='
'
TAB='	'

# ---------------------------------------------------------------------------
# Maps — associative arrays emulated with plain variables, so they work on
# bash 3.2. Keys are mangled into a variable-safe suffix; the original keys are
# kept in a list so they can be iterated in insertion order.
#
#   map_put MAP KEY VALUE     store (MAP must be a plain identifier, e.g. OLDV)
#   map_get MAP KEY           -> value in $REPLY ("" when absent)
#   map_has MAP KEY           exit 0 when the key exists
#   map_keys MAP              -> newline-separated keys in $REPLY
#
# The get/has/keys helpers return through $REPLY on purpose: `$( … )` would fork
# a subshell for every lookup, which is painfully slow on Windows.
# ---------------------------------------------------------------------------

map_put() {
  local mk="${2//[^A-Za-z0-9]/_}"
  if eval "[ \"\${__M_${1}_${mk}+x}\" != x ]"; then
    eval "__K_${1}=\"\${__K_${1}-}\$2\$NL\""
  fi
  eval "__M_${1}_${mk}=\$3"
}

map_get() {
  local mk="${2//[^A-Za-z0-9]/_}"
  eval "REPLY=\${__M_${1}_${mk}-}"
}

map_has() {
  local mk="${2//[^A-Za-z0-9]/_}"
  eval "[ \"\${__M_${1}_${mk}+x}\" = x ]"
}

map_keys() {
  eval "REPLY=\${__K_${1}-}"
}

# bump a counter stored in a map
map_inc() {
  local mk="${2//[^A-Za-z0-9]/_}" cur
  map_get "$1" "$2"; cur="$REPLY"
  map_put "$1" "$2" "$(( ${cur:-0} + 1 ))"
}

# ---------------------------------------------------------------------------
# norm_var — lowercase, alphanumerics only (used to compare a CHANGELOG entry
# name with a catalog alias). Pure bash: no `tr` subprocess, no bash-4 ${var,,}.
# ---------------------------------------------------------------------------

_LIB_UPPER='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
_LIB_LOWER='abcdefghijklmnopqrstuvwxyz'

norm_var() {
  local s="$1" out="" i c t
  i=0
  while [ "$i" -lt "${#s}" ]; do
    c="${s:$i:1}"
    case "$c" in
      [a-z0-9]) out="$out$c" ;;
      [A-Z])    t="${_LIB_UPPER%%"$c"*}"; out="$out${_LIB_LOWER:${#t}:1}" ;;
    esac
    i=$(( i + 1 ))
  done
  REPLY="$out"
}

# ---------------------------------------------------------------------------
# Version ordering. macOS `sort` may not support -V, so detect it once and fall
# back to an awk key transform (numeric runs zero-padded, everything else kept),
# which reproduces the ordering the scripts rely on:
#   1.9 < 1.10 ;  2.60 < 2.60.1 ;  1.0 < 1.0-rc1 (a prefix sorts first)
# ---------------------------------------------------------------------------

# override with _LIB_SORTV=awk to exercise the fallback used on macOS
_LIB_SORTV="${_LIB_SORTV:-}"

_vsort_probe() {
  if [ "$(printf '1.9\n1.10\n' | sort -V 2>/dev/null | tail -1)" = "1.10" ]; then
    _LIB_SORTV=native
  else
    _LIB_SORTV=awk
  fi
}

vsort() { # stdin: one version per line -> stdout: ascending
  [ -n "$_LIB_SORTV" ] || _vsort_probe
  if [ "$_LIB_SORTV" = native ]; then
    sort -V
  else
    awk '
      {
        s = $0; key = ""
        while (length(s) > 0) {
          if (match(s, /^[0-9]+/)) {
            key = key sprintf("%010d", substr(s, 1, RLENGTH) + 0)
          } else {
            match(s, /^[^0-9]+/)
            key = key substr(s, 1, RLENGTH)
          }
          s = substr(s, RLENGTH + 1)
        }
        print key "\t" $0
      }' | LC_ALL=C sort | cut -f2-
  fi
}

vmax() { # $1 $2 -> the higher version on stdout
  printf '%s\n%s\n' "$1" "$2" | vsort | tail -1
}

vge() { # exit 0 when $1 >= $2
  [ "$(vmax "$1" "$2")" = "$1" ]
}

# ---------------------------------------------------------------------------
# TOML helpers — extracting "alias<TAB>value" pairs with awk (portable) instead
# of a sed replacement containing \t (which BSD sed would print literally).
# ---------------------------------------------------------------------------

toml_versions() { # stdin: libs.versions.toml -> "alias<TAB>version" from [versions]
  awk '
    /^\[versions\]/ { inv = 1; next }
    /^\[(libraries|plugins|bundles)\]/ { inv = 0 }
    inv && match($0, /^[A-Za-z0-9_.-]+[ \t]*=[ \t]*"[^"]+"/) {
      line = substr($0, RSTART, RLENGTH)
      alias = line; sub(/[ \t]*=.*$/, "", alias)
      v = line; sub(/^[^"]*"/, "", v); sub(/".*$/, "", v)
      print alias "\t" v
    }'
}

toml_modules() { # stdin: libs.versions.toml -> "alias<TAB>module-or-plugin-id"
  # handles every declaration style used in the catalogs:
  #   alias = { module = "group:artifact", version.ref = "…" }
  #   alias = { group = "group", name = "artifact", version.ref = "…" }
  #   alias = { id = "plugin.id", version.ref = "…" }
  awk '
    function val(line, key,   re, s) {
      # a leading space is prepended by the caller so the key can always be
      # required to start after a non-name character (no "^" inside a group,
      # which older BSD awk handles poorly in a dynamic regex)
      re = "[^a-zA-Z.]" key "[ \t]*=[ \t]*\"[^\"]+\""
      if (!match(line, re)) return ""
      s = substr(line, RSTART, RLENGTH)
      sub(/^[^"]*"/, "", s); sub(/".*$/, "", s)
      return s
    }
    /^[A-Za-z0-9_.-]+[ \t]*=[ \t]*\{/ {
      alias = $0; sub(/[ \t]*=.*$/, "", alias)
      line = " " $0
      id = val(line, "id"); mod = val(line, "module")
      grp = val(line, "group"); nam = val(line, "name")
      out = ""
      if (id != "") out = id
      else if (mod != "") out = mod
      else if (grp != "" && nam != "") out = grp ":" nam
      if (out != "") print alias "\t" out
    }'
}

diff_added_versions() { # stdin: a diff -> "alias<TAB>version" for added [versions] lines
  awk '
    match($0, /^\+[A-Za-z0-9_.-]+[ \t]*=[ \t]*"[^"]+"/) {
      line = substr($0, RSTART + 1, RLENGTH - 1)
      alias = line; sub(/[ \t]*=.*$/, "", alias)
      v = line; sub(/^[^"]*"/, "", v); sub(/".*$/, "", v)
      print alias "\t" v
    }'
}
