# phpdemo
The purpose of this repository is to provide a simple demo application to exercise a LAMP stack.
## Predicates for Use
A LAMP (Linux Apache MySQL PHP) stack installed and running.
phpdemo requires the use of dotenv (vlucas/phpdotenv) to allow you to more securely store your database credentials. The easiest way of installing dotenv is to use composer. The installation section below details how to both install composer on your server and include dotenv in the application.
## Installation
The following steps are required:
1. Clone the repository to a directory on the server running PHP and Apache.
2. Change directory to phpdemo/scripts and run the getComposer.sh script. Please note this script was taken from https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md and has been included for convenience.
3. Install MySQL Shell, then use it to run the createDb.sql script. This will create the database and populate its schema.
4. Change directory to phpdemo/src then copy the names.php file to the document root of your Apache web server (e.g. /var/www/html or your virtual host's document root).
5. Create a directory to host a .env file. To conform with the code in names.php this should be located outside of the document root and be called config. For example if the document root is /var/www/html then create /var/www/config. Creating this directory outside of the document root helps prevent hackers from accessing the database credentials that will be stored in a file called .env
6. Create the .env file in the config directory. Entries take the form, key="value". The keys that are required are DB_HOST, DB_USER, DB_PASS and DB_NAME. 
An example implementation of the above steps is shown below:
