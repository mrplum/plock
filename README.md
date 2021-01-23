# Plock

It's a TimeTracker application.

Disclaimer: We've build it in a learning context, it was the first project of

## Architecture

It is a typical Client/Server arquitecture. But there are different clients you can use depending of context desired.

#### User Context
Users are the stakeholders that track their hours in the app. They can upload their _worked/reported hours_ in intervals (we call them a _track_). To upload _Tracks_ there was built an API using GraphQL, this API is consumed by a Mobile App, which was created using React Native and Apollo to consume from this API.

#### Manager Context
Managers are users that can see reports about the collected _Tracks_ in their organizations, this kind of reports are real-time, to do this we've used ElasticSearch as search engine. Indexes in ElasticSearch are feeded using Sidekiq jobs (which uses Redis as the in-memory data structure store), this kind of tech allow us to generate reports almost in real time, once an user load a _Track_ it's included in the next report query.

The manager UI is a typical rails interface and to generate reports we've used D3 visualization library.

#### Admin Context
There is a last context where there exists super admin users that can see the whole system information, this site was build using React.js.

![arquitecture](https://github.com/mrplum/plock/blob/doc/arquitecture.png)

* Ruby version
  2.6.2

## Getting Started

Server was dockerized, so all you need to get running the project is

```
docker-compose build
docker-compose up
```

* Database creation & initialization
  The very first time you will need to create DBs and run a seed file to get some dummy data pre-loaded
  ```
    docker-compose run web rails db:setup
  ```

* How to run the test suite

* Code style

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
  heroku

* ...
