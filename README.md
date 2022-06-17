# phpdemo
The purpose of this repository is to provide a simple demo application to exercise a LAMP stack.
## Predicates for Use
A LAMP (Linux Apache MySQL PHP) stack installed and running.
phpdemo requires the use of dotenv (vlucas/phpdotenv) to allow you to more securely store your database credentials. The easiest way of installing dotenv is to use composer. The installation section below details how to both install composer on your server and include dotenv in the application.
## Installation
The following steps are required (a Red Hat variant of Linux is assumed):
1. Install git on the server running PHP/Apache (if it is not already in place):
```shell
sudo dnf install git
```
2. Clone this repository to a staging directory 
```shell
cd $HOME
mkdir stage
cd stage
git clone https://github.com/swdavey/phpdemo.git
```
3. Change directory to phpdemo/scripts and run the getComposer.sh script. Please note this script was taken from https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md and has been included for convenience. Suggestion: for ease of use move the resultant composer.phar to /usr/local/bin. 
```shell
cd ~/stage/phpdemo/scripts
chmod 0700 getComposer.sh
./getComposer.sh
sudo mv composer.phar /usr/local/bin/composer
sudo chmod 0755 /usr/local/bin/composer
```
4. Install MySQL Shell, then use it to run the createdb.sql script. This will create the database and populate its schema. You will need to run this script using an administrative user (i.e. capable of creating the database, table and inserting data). Before running the script edit it to provide the application user with a password. 
```shell
cd ~/stage/phpdemo/scripts
sudo dnf install mysql-shell
mysqlsh --uri <username>@<database-host> -f createdb.sql
```
5. Change directory to phpdemo/src then copy the names.php file to the document root of your Apache web server (e.g. /var/www/html or your virtual host's document root). Change into the document root then install dotenv and its dependencies using composer.
```shell
cd ~/stage/phpdemo/src
sudo cp names.php /var/www/html
sudo cd /var/www/html
sudo composer require vlucas/phpdotenv
```
6. Create a directory to host a .env file. To conform with the code in names.php this should be located outside of the document root and be called config. For example if the document root is /var/www/html then create /var/www/config. Creating this directory outside of the document root helps prevent hackers from accessing the database credentials that will be stored in a file called .env
```shell
sudo mkdir -p /var/www/config
```
7. Create the .env file in the config directory. Entries take the form, key="value". The keys that are required are DB_HOST, DB_USER, DB_PASS and DB_NAME. Example values are shown below, change them to suit your circumstance (note the IP address could be changed for a hostname):
```shell
sudo -s 
touch /var/www/config/.env
echo 'DB_HOST="10.0.20.203"' >> /var/www/config
echo 'DB_USER="appuser"' >> /var/www/config
echo 'DB_PASS="My#Pa55w0rd"' >> /var/www/config
echo 'DB_NAME="db1"' >> /var/www/config
exit
```
# Running and Troubleshooting
You should now be able to go to your browser and navigate to your webpage, e.g http://<server-ip-address>/names.php . 
If the page does not display check that apache is properly working. For example on a Red Hat / Fedora / Centos / Oracle Linux system run:
```shell
systemctl status httpd
```
Make alterations based on the output. If Apache is running correctly, check that you deployed to the document root and/or your virtual hosts are set up correctly.
  
**Red Hat / Red Hat variants only.** 
  
If the page partially displays (i.e. is missing data that should have come from the database) then this may be a problem with selinux (typically enabled and enforcing by default). To resolve start by testing using PHP on the command line:
```shell
php /var/www/html/names.php
```
This should display the output html and should include a list of names from the database. Assuming this works, check whether selinux is in use.
```shell
getenforce
```
If the system responds with Enforcing then selinux is in use. By default selinux disallows Apache from making remote connections to databases. To overcome this issue you can either disable selinux (not recommended) or preferably configure selinux as shown below:
```shell
sudo setsebool -P httpd_can_network_connect_db 1
sudo systemctl restart httpd
```
Now re-test with a browser.
  
If you are using virtual hosts then you will probably need to set selinux policies to allow access to non-default directories and files as well as for logging and caches. The following assumes a virtual host which uses /webapp as its document root:
  ```shell
sudo dnf install policycoreutils-python-utils
semanage fcontext -a -t httpd_sys_content_t "/webapps(/.*)?" 
semanage fcontext -a -t httpd_log_t "/webapps/logs(/.*)?"
semanage fcontext -a -t httpd_cache_t "/webapps/cache(/.*)?“
sudo systemctl restart httpd
```
Re-test with a browser.
