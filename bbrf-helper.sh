#!/bin/bash

echo "👋 bbrf-helper v1"

if [[ -z "$2" ]]; then
  echo "🤔 Usage: ./bbrf_helper.sh <type> <input>"
  exit 1;
fi

type="$1";
file="$2";
tmp_folder="~/tmp-bbrfhelper";

if [ $type = "domains" ]; then
  echo "🎉";

  mkdir -p $tmp_folder
  file_temp="$tmp_folder/temp_domains.txt";
  file_temp_apexes="$tmp_folder/temp_apexes.txt"
  rm -f $file_temp;

  cat $file | anew > $file_temp
  cat $file_temp | unfurl apexes | anew > $file_temp_apexes

  while read -r line; do
    echo "new task...";

    # Replace all periods (".") in the line with underscores ("_")
    line_content=$(echo "$line" | tr '.' '_')

    # Run the bbrf commands with the modified line content
    bbrf new "$line_content";
    bbrf use "$line_content";
    bbrf inscope add "*.$line";
    cat $file_temp | grep "$line" | bbrf domain add -

    echo "👍 finished for $line";
  done < "$file_temp_apexes"
else
  echo "only domains supported now 😔"
  exit 1;
fi


rm -rf $tmp_folder
