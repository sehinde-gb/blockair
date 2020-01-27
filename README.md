# Blockair Instructions
A blockchain application built as a dapp with laravel infrastructure on the backend that uses flight bookings api data to create journey data that is placed on the blockchain

#Install Instructions

At the command line use gitclone to clone to a directory of your choosing
If you are using Laravel Valet browse to the blockair directory and use valet link to link the directory
At the command prompt type mysql -u root and create a new database by following the instructions below
Type CREATE DATABASE blockair;
Type exit;
Within the blockair directory run php artisan migrate to migrate the database
Check to see if the database has migrated using your own SQL software I use table plus to check to see if the databases are migrated.
Go to the blockair-dapp directory
Type which truffle to find out the version of truffle you are using.
If you dont have truffle installed install it here https://www.trufflesuite.com/docs/truffle/getting-started/installation
Go to the migrations directory and run truffle migrate
Install Granache here https://www.trufflesuite.com/docs/ganache/quickstart
Once installed go to the contracts tab and check to see if the truffle migrations have run correctly.
Go to blockair.test and create a new account
Login using that account and test
