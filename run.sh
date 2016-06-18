#!/bin/bash

BRANCH="$1"
if [ -z "$BRANCH" ]
then
  echo "USAGE: $0 BRANCH"
  echo "       BRANCH is one of: stable master"
  echo "       which was built with BRANCH=<branch> make. See README.md file."
  exit 1
fi

BASE=redeclipse-git-$BRANCH
if [ ! -d "$BASE" ]
then
  echo "ERROR: You must first build Red Eclipse using the command:"
  echo "       BRANCH=$BRANCH make"
  exit 1
fi

cd $BASE

# Run RedEclipse with hardcoded width and height and disable
# fullscreen because in full screen mode, when you exit it fouls up
# the display which requires the user to go through a annoying
# logout/login ritual:
./redeclipse.sh -df 0 -dw1856 -dh1150
