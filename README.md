# BOOK SWAP APP

[![Semaphore Pipeline](https://tatiana-panf.semaphoreci.com/badges/book-swap-app.svg?key=99efe26b-65de-4cb8-8c78-4b85480d5072)](https://tatiana-panf.semaphoreci.com/projects/book-swap-app)

## Context

An application allows users to create lists of their books (My library), to reserve books from other users and then to exchange these books.

## Project setup

Make sure you have Postgres server v12 running locally, either installed through your favourite package manager or as a docker container:
```
docker run --detach --name postgres-12 -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword postgres:12

```

To setup your local environment:

```bash
# this includes the postgres client (required for gem pg)
brew install postgresql

# includes `bundle install` and `db:setup`
bin/setup

bin/rails server
```
## Deployment

Deployment is automated through Semaphore promotions. Every successful push on master is automatically deployed on Staging.

