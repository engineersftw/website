#Engineers.SG Website

## Development Setup

### Getting the source code

The easiest way to do this is to check out the Git repository.

```
git clone https://github.com/engineersftw/website.git
```

The git repository will be checked out into a local folder named `website`.

***(If you are keen on contributing to this project, do [fork this repository](https://help.github.com/articles/fork-a-repo/) and check out from your own fork of the Git repository.)***

### Installing Ruby

1. Install [HomeBrew](http://brew.sh)

2. Install [rbenv](https://github.com/rbenv/rbenv)

	```
brew update
brew install rbenv ruby-build
```

3. Add `rbenv` support to your local profile

	```
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
```

	If you are using `zsh`:

	```
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
```

3. Install the current Ruby version

	```
rbenv install -l
rbenv install 2.3.0
```

4. Use it globally

	```
rbenv global 2.3.0
```

### Install Rails

1. Install Bundler

	```
gem install bundler
```

2. Install the rest of the Ruby Gems needed for the app (including 

	```
bundle install
```

### Prepare the Database

1. You will need [Postgres](http://www.postgresql.org) installed and started.

	> For newbies, I'd suggest that you download and install [PostGres Mac App](http://postgresapp.com).
	
2. Create the database

	```
bundle exec rake db:create
```

3. Create the database tables

	```
bundle exec rake db:migrate
```

4. Prepare sample data

	```
bundle exec rake db:seed
```

### Start the development web server

1. You can start the local development web server with the following command:

	```
foreman start
```

2. You can now visit the local development site at [http://localhost:3000](http://localhost:3000).

3. The Admin panel is accessible at [http://localhost:3000/admin](http://localhost:3000/admin). The admin login email is `admin@engineers.sg` and default password is `password`.

4. To stop the dev server, just press `ctrl` + `c` on your keyboard to stop the foreman process.

## Contributing

### Fork this repository

Please [fork this repository](https://help.github.com/articles/fork-a-repo/) and send us [pull requests](https://help.github.com/articles/using-pull-requests/).

### Testing your code

We use the [RSpec](http://rspec.info) testing framework for this app.

To run the test locally, use this command: `bundle exec rspec spec`

### UI Design and CSS framework

We use the [Materialize CSS](http://materializecss.com) framework for all the design and layout of the site. Please refer to their documentation for more details on how to work with their markup.

Stylesheets are written in SASS.

### Slim Templating Engine

All the views are written in [Slim](http://slim-lang.com) - a lightweight templating engine. Please refer to their documentation for more details.

All template files should end with the `.html.slim` extension.

## License

This software is released under the MIT License.

Copyright (C) 2016 Code Craft Pte Ltd

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.