# Ansible role for Sonar Upgrade

This role has been tested with Sonar upgrade on Centos 6 with MySQL database for following versions:
* 5.1.12 -> 5.4
* 5.4 -> 6.0


# Upgrade process

Sonar describes the upgrade process like this:

1. Stop the old SonarQube server
2. Download and unzip the new SonarQube distribution in a fresh directory, let's say NEW_SONARQUBE_HOME.
3. Start it using the default H2 database and use the update center to install the plugins you need.
4. Manually install any custom plugins.
5. Stop the new server.
6. Update the content of the sonar.properties and wrapper.conf files located in the NEW_SONARQUBE_HOME/conf directory with the content of the related files in the OLD_SONARQUBE_HOME/conf directory (web server URL, database settings, etc.). Do not copy-paste the old files.
7. If a custom JDBC driver is used, copy it into NEW_SONARQUBE_HOME/extensions/jdbc-driver/<dialect>.
8. (warning) Back up your database.
9. (warning) Remove the data/es directory.
10. Start the new web server
11. Browse to http://localhost:9000/setup (replace "localhost:9000" by your own URL) and follow the setup instructions.

After configuring given Ansible role this process will look like this:

1. Set new version in playbook
2. Run playbook for Sonar server
3. Browse to http://localhost:9000/setup (replace "localhost:9000" by your own URL) and follow the setup instructions.

Ansible role will cover all the rest including MySQL database backup and applying custom configuration.

# Variables

Following default variables have been defined:

| Variable          | Value           | Comment  |
| ------------------|-----------------|----------|
| sonar_user        | sonar | Under what user Sonar will be installed |
| sonar_home_root   | /home/sonar |  Root path hosting all Sonar versions |
| sonar_home        | {{ sonar_home_root }}/sonarqube-{{ sonar_target_version }}    | Home path of new Sonar version (upgrade target) |
| sonar_db_create_backup | true | Should backup be performed. Can be disabled for testing |
| sonar_db_name     | sonar | Database name |
| sonar_db_port     | 3306  | Database port |
| sonar_db_encoding | utf8  | Database encoding |
| mysql_connector_version | 5.1.38 | MySQL java connector version |
| sonar_plugins_url_file | default-sonar-plugins.yml | Additional yml file describing plugins that should be installed |

Following parameters are **required** to be defined at the playbook:

| Variable              | Comment  |
| ----------------------|----------|
| sonar_target_version  | Target version to upgrade to |
| sonar_db_host         | Database hostname |
| sonar_db_user         | Username for Sonar database |
| sonar_db_password     | Password for Sonar database |
| crowd_url             | Url for Atlassian Crowd |
| crowd_application     | Application name for Crowd access |
| crowd_password        | Application password for Crowd access |

# Current limitations

This was developed for use in Nortal so at the moment lacking bit of flexibility.

    * sonar properties and rest of configuration (wrapper config) templates could be externalized.
    * more database options could be added. Only MySQL at the moment.
    * requires integration with Atlassian Crowd as SSO provider
