#!/bin/bash
#python dedup_files.py mf_web.txt mf_lori.txt
#python dedup_files.py ckpjobs.txt mf_web.txt
file1=$1
file2=$2
echo "python dedup_files.py ${file1} ${file2}"
python dedup_files.py ${file1} ${file2}
