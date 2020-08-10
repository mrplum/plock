# README

## Ruby version
  - `ruby-2.6.2`

## Database creation
  - `rails db:create`

## Database initialization
  - `rails db:migrate db:seed`

# Run project

  ## Elasticsearch
  ```
  elasticsearch
  ```

  ## Redis
  ```
  redis-server
  ```

  ## Sidekiq
  ```
  bundle exec sidekiq -c 1 -q elasticsearch
  ```

  ## Rails
  ```
  rails s
  ```

# Deploy HEROKU

  - `heroku git:remote -a plock`

  - `git push heroku master`

  - `git push heroku develop:master -f`

  - `heroku logs -a plock -t`

  - `heroku run bash -a plock`

  - `heroku run rails db:migrate -a plock`

  - `heroku run worker`