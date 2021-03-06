#!/bin/bash

# Build a query from a folder containing results
# get the directory containing (recursively) the results
resdir=$1
# get the name of a table to insert into
table=$2


# make a temporary folder for the results
bdir=$(basename $resdir)
tdir="/tmp/sparseharness/$bdir"
echo "Making temp directory: $tdir"
mkdir -p $tdir

# build the file we will write to
qf=$tdir/query.sql
touch $qf
echo "" > $qf

# grep the results from the folder recursively, 
# and subsitute various parts of it

grep -r "INSERT" $resdir | sed "s/.*INSERT/INSERT/g" | sed "s/table_name/$table/g" > $qf

cp $qf .

