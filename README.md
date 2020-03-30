# Bookshelf

Bookshelf is an application for conveniently sorting and tracking books from your home library. Books can be added to the database using ISBN or manually, and later be assigned to the collections.

When adding a book to the database, you can see a short description of the book, its author(s), cover and short description.

You can easily see all the books by one author or all the books in the collection.

Bookshelf has a “borrowing history” for conveniently tracking your book: to whom, when, and by which date the book was put into use.

Bookshelf will support three languages: Simplified Chinese, Russian and English.

## Requirements

* Ruby 2.7.0

* Docker with compose

* PostgreSQL

## Configuration

For local development copy `.env.example` to `.env`

## Database

`rails db:create` to create empty database

`rails db:migrate` to run migrations

## Local development

`docker-compose up`

`foreman start`

## How to create an Entity-Relationship Diagram

`EAGER_LOAD=1 rails erd`
