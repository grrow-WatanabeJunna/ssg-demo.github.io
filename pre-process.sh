#!/usr/bin/env bash
#
# description:
#   correct directory or file name that begins with the underscore.

cd "$(dirname "${BASH_SOURCE:-$0}")" || exit

mv _next next

while read -r path; do
  begin_with_underscore="$(grep '/_' "${path}")"

  if [ -n "${begin_with_underscore}" ]; then
    correct_path="(echo ${path} | sed s/\\/_/\\//g )"

    mv "${path}" "${correct_path}" 

    sed -i index.html 's#'"${path}"'#'"${correct_path}"'#g'
  fi
done < <(find next -mindepth 1)

function escape_slash() {
  readonly _VALUE=$1

  echo "${_VALUE}" | sed s/\\//\\\\\\//g
}
