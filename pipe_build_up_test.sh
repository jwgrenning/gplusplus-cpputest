#!/bin/bash -Eeu

readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"
readonly TMP_DIR="$(mktemp -d /tmp/cyber-dojo-languages.XXXXXXX)"
remove_tmp_dir() { rm -rf "${TMP_DIR}" > /dev/null; }
trap remove_tmp_dir INT EXIT

script()
{
  local -r name=build_test_push_notify.sh
  local -r local_path="${MY_DIR}/../image_builder/${name}"
  local -r remote_path="https://raw.githubusercontent.com/cyber-dojo-languages/image_builder/master/${name}"
  if [ -f "${local_path}" ]; then
    echo "${local_path}"
  else
    curl --fail --output "${TMP_DIR}/${name}" --silent "${remote_path}"
    chmod 700 "${TMP_DIR}/${name}"
    echo "${TMP_DIR}/${name}"
  fi
}

"$(script)" "${MY_DIR}"
