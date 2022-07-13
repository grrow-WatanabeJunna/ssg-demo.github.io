#!/usr/bin/env bash
#
# description:
#   correct directory or file name that begins with the underscore.

readonly ORIGINAL_ASSETS_DIRECTORY=_next
readonly CORRECT_ASSETS_DIRECTORY=next
readonly PAGE=index.html
readonly BACKUP_PREFIX=.tmp

cd "$(dirname "${BASH_SOURCE:-$0}")" || exit

if [ -d ${ORIGINAL_ASSETS_DIRECTORY} ]; then
  rm -rf ${CORRECT_ASSETS_DIRECTORY}
  mv ${ORIGINAL_ASSETS_DIRECTORY} ${CORRECT_ASSETS_DIRECTORY}
  sed -i ${BACKUP_PREFIX} 's#'"/${ORIGINAL_ASSETS_DIRECTORY}"'#'"${CORRECT_ASSETS_DIRECTORY}"'#g' ${PAGE}
  rm -f ${PAGE}${BACKUP_PREFIX}
fi

while read -r path; do
  begin_with_underscore="$(echo "${path}" | grep '/_')"

  if [ -n "${begin_with_underscore}" ]; then
    correct_path="$(echo "${path}" | sed s/\\/_/\\//g )"

    mv "${path}" "${correct_path}" 

    sed -i ${BACKUP_PREFIX} 's#'"${path}"'#'"${correct_path}"'#g' ${PAGE}
    rm -f ${PAGE}${BACKUP_PREFIX}
  fi
done < <(find ${CORRECT_ASSETS_DIRECTORY} -mindepth 1)
