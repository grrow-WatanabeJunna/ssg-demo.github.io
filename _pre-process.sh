#!/usr/bin/env bash
#
# description:
#   correct directory or file name that begins with the underscore.

cd "$(dirname "${BASH_SOURCE:-$0}")" || exit

if [ -d _next ]; then
  mv _next next
fi

while read -r path; do
  begin_with_underscore="$(echo "${path}" | grep '/_')"

  if [ -n "${begin_with_underscore}" ]; then
    correct_path="$(echo "${path}" | sed s/\\/_/\\//g )"

    mv "${path}" "${correct_path}" 

    sed -i index.html -e 's#'"${path}"'#'"${correct_path}"'#g'
  fi
done < <(find next -mindepth 1)
