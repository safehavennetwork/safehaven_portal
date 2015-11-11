# Safe Haven Secure Portal

This application handles interaction between Shelters, Advocates, Clients, and Safe Haven volunteers.

# Setup

This is a pretty straightforward Rails application using MySQL for the database.

## Install Ruby and Rails

Your setup may vary, but we recommend using [rbenv](https://github.com/sstephenson/rbenv) or [RVM](https://rvm.io/) to version your ruby environments.  If you're on OS X, you can use [Homebrew](http://brew.sh/) to help make things easier.  If you're feeling adventurous, [RailsInstaller](http://railsinstaller.org/en) may get you up and running on Windows.  Please be aware that development on Windows will be different, and may require advanced knowledge when problems are encountered.


## Install MySQL [UPDATE NEEDED! NOW USING POSTGRESQL]

Checkout the MySQL [Installation Guides](http://dev.mysql.com/doc/refman/5.7/en/installing.html) for getting MySQL up and running on your machine.

Once that's done, be sure to add the safehaven user
```
mysql --user-root mysql
mysql> CREATE USER 'safehaven'@'localhost';
mysql> GRANT ALL PRIVELGES ON *.* TO 'safehaven'@'localhost';
```

## Clone the repo
```
git clone git@github.com:safehavennetwork/safehaven_portal.git
```

## Install Gems
```
bundle install
```

## Create and setup your database
```
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

## Spin up the app!
```
bundle exec rails s
```
