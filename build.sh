#!/bin/bash

[ ! "${EUID}" = "0" ] && {
  echo "Execute esse script como root:"
  echo
  echo "  sudo ${0}"
  echo
  exit 1
}

HERE="$(dirname "$(readlink -f "${0}")")"

working_dir=$(mktemp -d)

cp -rfv "${HERE}"/* ${working_dir}

sed -i "s|1.2.9|$(date +%y.%m.%d%H%M%S)|g" ${working_dir}/DEBIAN/control

rm ${working_dir}/build.sh
rm ${working_dir}/README.md
rm -R ${working_dir}/imgs
chmod -v -R +x ${working_dir}

dpkg -b ${working_dir}
rm -rfv ${working_dir}

mv "${working_dir}.deb" "${HERE}/welcome-studio_amd64.deb"

chmod 777 "${HERE}/welcome-studio_amd64.deb"
chmod -x  "${HERE}/welcome-studio_amd64.deb"
