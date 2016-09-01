#!/bin/sh

function exportHtml() {

MYSQL_DB=${1}

## export html
echo "<!DOCTYPE html>"
echo "<html lang="ja">"
echo "  <head>"
echo "    <meta charset=\"utf-8\">"
echo "    <title>Mysql DB Document : ${DB_NAME}</title>"  
echo "    <link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css\" integrity=\"sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u\" crossorigin=\"anonymous\" />"
echo "    <script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js\" integrity=\"sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa\" crossorigin=\"anonymous\"></script>"
echo "    <style>body { padding-top: 60px; }</style>"
echo "  </head>"
echo "  <body>"


echo "  <nav class=\"navbar navbar-default navbar-fixed-top\">"
echo "    <a class=\"navbar-brand\" href=\"#\">${MYSQL_HOST} DB定義書</a>"
echo "    <ul class=\"nav navbar-nav pull-right\">"
for DATABASE in ${DATABASES};
do
  if [ "${DATABASE}" == "${MYSQL_DB}" ]; then
    echo "    <li class=\"active\">"
  else
    echo "    <li>"
  fi
  echo "      <a href=\"${DATABASE}.html\">${DATABASE}</a>"
  echo "    </li>"
done
echo "    </ul>"
echo "  </nav>"
echo "  <p class=\"pull-right\">generated by `hostname`. last updated : `date '+%Y/%m/%d %H:%M:%S'`</p>"

if [ "${MYSQL_DB}" != "" ]; then
  echo "  <div class=\"container\">"
  echo "  <h3>${MYSQL_DB} テーブル一覧</h3>"

  echo "  <div class=\"row\">"

  echo "  <div class=\"col-md-8\">"
  # テーブル一覧表示
  TABLES=`echo "show tables;" | ${MYSQL} ${MYSQL_DB} -s`
  for TABLE_NAME in ${TABLES};  
  do
    TABLE_STATUS=(`echo "show table status like '${TABLE_NAME}'" | ${MYSQL} ${MYSQL_DB} -s`)
    echo "  <label id="${TABLE_NAME}">${TABLE_NAME} : ${TABLE_STATUS[17]}</label>"
    echo "  <table class=\"table table-bordered table-hover\">"
    echo "    <tr><th>カラム名</th><th>日本語</th><th>型</th><th>Null</th><th>Key</th><th>デフォルト値</th>"
    echo "show full columns from ${TABLE_NAME};" | ${MYSQL} ${MYSQL_DB} -s | sed 's/\\n//g' | awk -F'\t' '{print "<tr><td>"$1"</td><td>"$9"</td><td>"$2"</td><td>"$4"</td><td>"$5"</td><td>"$6"</td></tr>"}'
    echo "  </table>"
  done

  echo "  </div>"

  # メニュー表示
  echo "  <div class=\"col-md-4\">"
  echo "    <div class=\"list-group affix\">"
  echo "      <span class=\"list-group-item list-group-item-info\">Tables</span>"
  for TABLE_NAME in ${TABLES};
  do
    echo "      <a class=\"list-group-item\" href=\"#${TABLE_NAME}\">${TABLE_NAME}</a>"
  done
  echo "    </ul>"

  echo "  </div>"
  echo "  </div>"
  echo "  </div>"
fi

echo "  </body>"
echo "</html>"

}

