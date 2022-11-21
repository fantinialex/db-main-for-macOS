#!/bin/sh
export DB_MAIN_BIN=~/db-main/bin
export PATH=$DB_MAIN_BIN:$PATH
export LD_LIBRARY_PATH=$DB_MAIN_BIN:$DB_MAIN_BIN/../java/jre/lib/amd64/server:$LD_LIBRARY_PATH
cd ~/db-main/bin
db_main