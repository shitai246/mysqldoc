#!/bin/sh
BASEDIR=$(cd $(dirname $0);pwd)

. ${BASEDIR}/config.sh
. ${BASEDIR}/exportHtml.sh

mkdir -p ${OUTPUT_DIR}
for DB in ${DATABASES};
do
  exportHtml ${DB} > ${OUTPUT_DIR}/${DB}.html
done

exportHtml > ${OUTPUT_DIR}/index.html

exit 0;

