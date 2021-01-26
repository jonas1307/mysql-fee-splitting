
# Payment fee splitting 
This project is a study for meeting a business requirement, where a system with pre-paid balance needs to calculate and deduct a transaction fee before funding the final client.

For this project, I tried to implement a algorithm similar to IRS brackets, where the fee is calculated accordingly to dynamic tiers of spending.

This work is still in progress, but when the development is finished, this repository should contain a stored procedure, functions or other database objects that returns a report with usages, fees and the final value to a date range.

# Example of use

A customer recharges his account using two different credit cards, with two different fees each:

- $10 - Mastercard - 7.50% fee
- $25 - Amex - 9.00% fee

Then this customer uses his credits twice:

- $ 12.50 - charged on jan 26th 2021
- $ 12.50 - charged on jan 26th 2021

At the end of the month, the system calculates the corresponding fee for each transaction, where:
- 7.50% is applied to the fist $10
- 9.00% is applied to the remaining $15 ($2.50 plus $12.50)

For achieving my needs, I'll create a custom bracket solution for charging the fee, where:
- From 0.00 to 10.00, I'll charge a 7.50% fee
- From 10.00 to 25.00 I'll charge a 9.00% fee

As the balance increases, the fee will be calculated adding a "padding" value from the previous usages' sum, and create new brackets for charging the fee correctly.

## Installation
First of all, you need to have Docker and docker-compose installed.

Clone this repository on your machine and run the following command:

```
docker-compose up
```

Then, choose a database tool you like (for me, It's currently [DBeaver](https://dbeaver.io/)) and connect to the server you just lanched using the following settings:

```
server: localhost:3306
database: washngo
username/password: dev
``` 

> You can alternatively use [adminer](https://www.adminer.org/) to import the seed.sql file and manage the database. Adminer is already included in the docker-compose file in this repository. Navigate to http://localhost:8080 using your browser and connect using the same settings provided above.

Run the script contained in ```seed.sql``` file

The file ```queries.sql``` contains the queries I've written so far.

## License
This project is licensed under [MIT](https://choosealicense.com/licenses/mit/) terms.
