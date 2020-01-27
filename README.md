# Blockair Instructions
A blockchain application built as a dapp with laravel infrastructure on the backend that uses flight bookings api data to create journey data that is placed on the blockchain

#Install Instructions
(Note this project has a Laravel Backend and a Vue JS SPA Front End)

#1 At the command line use gitclone to clone to a directory of your choosing
#2 If you are using Laravel Valet browse to the blockair directory and use valet link to link the directory
#3 At the command prompt type mysql -u root and create a new database by following the instructions below
#4 Type CREATE DATABASE blockair;
#5 Type exit;
#6 Within the blockair directory run php artisan migrate to migrate the database
#7 Check to see if the database has migrated using your own SQL software I use table plus to check to see if the databases are migrated.
#8 Go to the blockair-dapp directory
#9 Type which truffle to find out the version of truffle you are using.
#10 If you dont have truffle installed install it here https://www.trufflesuite.com/docs/truffle/getting-started/installation
#11 Go to the migrations directory and run truffle migrate
#12 Install Granache here https://www.trufflesuite.com/docs/ganache/quickstart
#13 Once installed go to the contracts tab and check to see if the truffle migrations have run correctly.
#14 Go to blockair.test and create a new account
#15 Login using that account and test
