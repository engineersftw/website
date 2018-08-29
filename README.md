# [Engineers.SG website](https://engineers.sg/)

[![Build Status](https://travis-ci.org/engineersftw/website.svg?branch=develop)](https://travis-ci.org/engineersftw/website)
[![Code Climate](https://codeclimate.com/github/engineersftw/website/badges/gpa.svg)](https://codeclimate.com/github/engineersftw/website)

## Development Setup

### Getting the source code

The easiest way to do this is to check out the Git repository:

```
git clone https://github.com/engineersftw/website.git
```

The git repository will be checked out into a local folder named `website`.

***(If you are keen on contributing to this project, do [fork this repository](https://help.github.com/articles/fork-a-repo/) and check out from your own fork of the Git repository.)***

### Install Ruby

1. Install [Homebrew](http://brew.sh).

2. Install [rbenv](https://github.com/rbenv/rbenv):

    ```
    brew update
    brew install rbenv ruby-build
    ```

3. Add `rbenv` support to your local profile:

    ```
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    ```
    
    If you are using `zsh`:
    
    ```
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
    ```

3. Install the current Ruby version:

    ```
    rbenv install -l
    rbenv install 2.3.0
    ```

4. Use it globally:

    ```
    rbenv global 2.3.0
    ```

### Install PostgreSQL

1. You will need [PostgreSQL](http://www.postgresql.org) installed and started.

    > For newbies, I'd suggest that you download and install [Postgres Mac App](http://postgresapp.com). You may need to edit `config/database.yml` to [connect via TCP socket](http://postgresapp.com/documentation/configuration-ruby.html).

2. Ensure that the PostgreSQL binaries are on your path.  If you are using Postgres Mac App, you can do that like this:

    ```
    echo 'export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"' >> ~/.bash_profile

    source ~/.bash_profile
    ```

    This will provide access to `pg_restore` and `pg_config` (which is needed later to compile the `pg` gem).

### Install Node.js

1. Node.js is required for some of the Ruby gems. (There are [alternatives](https://github.com/sstephenson/execjs).)

	Install Node.js:

    ```
    brew install node
    ```

### Install Rails

1. Install [Bundler](http://bundler.io/):

    ```
    gem install bundler
    ```

2. Install the rest of the Ruby Gems needed for the app (including Ruby on Rails):

    ```
    bundle install
    ```

### Prepare the Database


1. Create the database:

    ```
    bundle exec rake db:create
    ```

2. Create the database tables:

    ```
    bundle exec rake db:migrate
    ```

3. Prepare sample data:

    ```
    pg_restore --verbose --clean --no-acl --no-owner -h localhost -d website_development db/snapshot.dump
    ```

### Start the development web server

1. Prepare the environment file (one time exercise):

    ```
    cp env.sample .env
    ```

2. You can start the local development web server with the following command:

    ```
    foreman start
    ```

3. You can now visit the local development site at [http://localhost:3000](http://localhost:3000).

4. The Admin panel is accessible at [http://localhost:3000/admin](http://localhost:3000/admin). The admin login email is `admin@engineers.sg` and the default password is `password1234`.

5. To stop the dev server, just press `ctrl` + `c` on your keyboard to stop the foreman process.

## Contributing

### Fork this repository

Please [fork this repository](https://help.github.com/articles/fork-a-repo/) and send us [pull requests](https://help.github.com/articles/using-pull-requests/) to the `develop` branch.

### Testing your code

We use the [RSpec](http://rspec.info) testing framework for this app.

To run the test locally, use this command: `bundle exec rspec spec`

### UI Design and CSS framework

We use the [Materialize CSS](http://materializecss.com) framework for all the design and layout of the site. Please refer to their documentation for more details on how to work with their markup.

Stylesheets are written in SASS.

### Slim Templating Engine

All the views are written in [Slim](http://slim-lang.com) - a lightweight templating engine. Please refer to their documentation for more details.

All template files should end with the `.html.slim` extension.

## Contributors

- [Michael Cheng](https://github.com/miccheng)
- [Valentine Chua](https://github.com/valentine)
- [Sahil Bajaj](https://github.com/spinningarrow)
- [Ted Johansson](https://github.com/drenmi)
- [Casie Millhouse-Singh](https://github.com/casielane)
- [Oon Xin Tian](https://github.com/oxtian)
- [Sharon Yeo](https://github.com/codingsharon)

## License

This software is released under the MIT License.

Copyright (C) 2017 Code Craft Pte Ltd

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
