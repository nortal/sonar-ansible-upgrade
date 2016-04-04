#!/bin/bash

TESTS_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

TEST_COMMAND="cd /playbooks && ansible-playbook $@ -i 'localhost,' -c local --extra-vars 'sonar_db_create_backup=false' upgrade-sonar.yml"

# Cleanup leftover containers
docker rm $(docker ps -a -q)

# Run container mounting playbooks as volume
docker run -v "$TESTS_DIR/../playbooks/:/playbooks:rw" 'sonar-upgrade-test' /bin/bash -c "${TEST_COMMAND}"
