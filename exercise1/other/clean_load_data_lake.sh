#!/bin/bash

#starting directory
start_dir=$(pwd)

#"safe" removing directorues
rm /data/staging/exercise_1/*
rmdir /data/staging/exercise_1/
rmdir staging



hdfs dfs -rm -rf /user/w205/hospital_compare

cd /data/staging/exercise_1