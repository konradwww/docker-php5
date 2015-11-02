# docker-php5
- docker PHP5 container linked to official mysql container
- symfony 2.7.3 ready

# setup
1. install virtualbox and kitematic
2. cd docker-php5
3. docker-compose build
4. docker-compose up -d
5. goto http://192.168.99.100

#MySQL DB Setup
- host: 192.168.99.100
- port: 3306
- user: root
- password: root

# Symfony2 installation
1. symfony new symfony_temp_dir
2. cp -rf symfony_temp_dir/ docker-php5/

