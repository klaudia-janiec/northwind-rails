# README

## Project setup using Ubuntu

### Setup PostgreSQL

1. Install Postgres  
  `$ sudo apt-get update`  
  `$ sudo apt-get install postgresql postgresql-contrib libpq-dev`  

2. Create database user  
  `$ sudo -u postgres createuser -s pguser`  

3. Set database user password  
  `$ sudo -u postgres psql`  
  `postgres=# \password pguser`  
  `postgres=# \q`  

### Setup ruby  

1. Install `rbenv` using this [guide](https://github.com/rbenv/rbenv/blob/master/README.md)  

2. Install `ruby-build` using this [guide](https://github.com/rbenv/ruby-build/blob/master/README.md)  

3. Install ruby and bundler  
  `$ rbenv install 2.4.2`  

### Setup project

**_Attention_**:
  *JavaScript runtime is needed to run app, e.g. NodeJS (`apt-get install nodejs`)  
  For other supported runtimes see https://github.com/rails/execjs*  

Go to directory where you have cloned the repository.  

1. Prepare `.env` configuration file  
  `$ cp .env.example .env`

2. Add `.env` with data:  

   ```
   RAILS_MAX_THREADS = 1
   DATABASE_HOST = localhost
   DATABASE_USER = pguser
   DATABASE_PASSWORD = YOUR_PASSWORD
   ```

3. Install required gems  
  `$ gem install bundler`  
  `$ bundle install`

4. Create database  

  `$ bin/rails db:create`  

   In case `PG::Error: ERROR:  new encoding (UTF8) is incompatible with the encoding of the template database (SQL_ASCII)` error, follow the [instructions](https://stackoverflow.com/a/16737776/2867427)  

5. Migrate database
  `$ bin/rails db:migrate`

6. Seed database
  `$ bin/rails db:seed`

7. Drop, create, migrate and seed database
  `$ bin/rails db:drop db:create db:migrate db:seed`

8. Get records from database (in example get records which have association with shipper, customer, employee)
  `$ bin/rails console` or `$ bin/rails c`
  `irb(main):001:0> Order.where.not(ship_via: nil, customer_id: nil, employee_id: nil)`
