#!/bin/bash

export RUN_AS_USER={{ sonar_user }}
SONAR_HOME={{ sonar_home }}
/bin/bash $SONAR_HOME/bin/linux-x86-64/sonar.sh $@