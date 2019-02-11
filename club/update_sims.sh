#!/bin/bash

./scrapers/all_games.rb 2017 2017
./scrapers/all_xml.rb 2017 2017

./scripts/all_parse_xml.sh 2017 2017

./load.sh
./load_gamecast.sh

./clean.sh
./alias.sh

psql soccer -f sql/league_sizes.sql
psql soccer -f keys/intraleague_keys.sql

./sos_leagues.sh

cd python
./predict.py

cd ..

cd sim_results

./sim.sh english+premier+league
./sim.sh english+league+championship
./sim.sh english+league+one
./sim.sh english+league+two
./sim.sh english+national+league

./sim.sh australian+a-league

./sim.sh austrian+bundesliga

./sim.sh belgian+jupiler+league

./sim.sh danish+sas-ligaen

./sim.sh dutch+eredivisie

./sim.sh french+ligue+1
./sim.sh french+ligue+2

./sim.sh german+bundesliga
./sim.sh german+2.+bundesliga

./sim.sh greek+super+league

./sim.sh indian+super+league

./sim.sh israeli+premier+league

./sim.sh italian+serie+a
./sim.sh italian+serie+b

./sim.sh japanese+j+league

./sim.sh northern+irish+premiership

./sim.sh portuguese+liga

./sim.sh romanian+first+division

./sim.sh russian+premier+league

./sim.sh scottish+premiership
./sim.sh scottish+championship
./sim.sh scottish+league+one
./sim.sh scottish+league+two

./sim.sh spanish+primera+división
./sim.sh spanish+segunda+division

./sim.sh swiss+super+league

./sim.sh turkish+super+lig

cd ..
