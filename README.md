# README

For Ubuntu:
1. Install Postgres.  
  `$ sudo apt-get update`  
	`$ sudo apt-get install postgresql postgresql-contrib libpq-dev`

2. Create database user  
  `$ sudo -u postgres createuser -s pguser`  
  `$ sudo -u postgres psql`

3. Set database user password  
  `postgres=# \password pguser`  
  `postgres=# \q`

4. Copy `.env.example` to `.env`.

5. Add database user password to .env as `DATABASE_PASSWORD`.

6. Create database  
  `$ bin/rails db:create`
