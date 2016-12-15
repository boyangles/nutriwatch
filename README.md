# nutriwatch
A central hub for individuals to find foods that suit their needs.

# Database Setup:
We used Postgresql to set up our database. Under nutriwatch/data you can find our `setup.sql` file. To set up, simply run the following commands:

1. `createdb nutriwatch`
2. `psql nutriwatch -af setup.sql`

Note setup.sql requires the injection of CSV files as production data. These CSV files were hand-crafted and obtained from Duke University restaurants on campus.

To run our application, you need to have a working version of Ruby as well as Rails. Once you have installed Ruby and pulled from this website, execute the following steps:

1. Ensure that the Gemfile is up to date with the remote repository
2. In the terminal, run `bundle install`
3. Set up the rails server by running `rails server`
4. Go to http://localhost:3000
5. Congrats, you're running Nutriwatch!
