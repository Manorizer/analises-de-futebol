#!/bin/bash

psql soccer -c "drop table if exists aleague.results;"

psql soccer -f sos/standardized_results.sql

psql soccer -c "vacuum full verbose analyze aleague.results;"

psql soccer -c "drop table if exists aleague._basic_factors;"
psql soccer -c "drop table if exists aleague._parameter_levels;"

R --vanilla -f sos/lmer.R

psql soccer -c "vacuum full verbose analyze aleague._parameter_levels;"
psql soccer -c "vacuum full verbose analyze aleague._basic_factors;"

psql soccer -f sos/normalize_factors.sql
psql soccer -c "vacuum full verbose analyze aleague._factors;"

psql soccer -f sos/schedule_factors.sql
psql soccer -c "vacuum full verbose analyze aleague._schedule_factors;"

psql soccer -f sos/current_ranking.sql > sos/current_ranking.txt
cp /tmp/current_ranking.csv sos/current_ranking.csv

psql soccer -f sos/predictions.sql > sos/predictions.txt
cp /tmp/predictions.csv sos/predictions.csv
