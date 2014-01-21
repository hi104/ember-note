ember-note
===========

markdown note application

This is my ember.js practice

## install

```
bundle install
bower install
rake db:migrate
```
create .env and edit for initializers/omniauth.rb

## heroku config
```
heroku config:set GITHUB_KEY="xxxxxxxxxxxxxxxx"
heroku config:set GITHUB_SECRET"xxxxxxxxxxxxxxxx"
```
use in initializers/omniauth.rb

## using
- rails 4.0.1
- ember.js 1.4.0-beta.1
- ember-data 1.0.0-beta.4
- ember-addons.bs_for_ember

License
-----------------

Copyright 2014 Hitoshi Nakada

Licensed under the MIT License
