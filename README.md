# FOLD Interview Project: To-Do Backend API


<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li><a href="#getting-started">Getting Started</a></li>
      <ol>
        <li><a href="#install-locally">Install Locally</a></li>
      </ol>
    <li><a href="#my-process">My Process</a></li>
      <ol>
        <li><a href="#initial-thoughts">Initial Thoughts</a></li>
        <li><a href="#feature-implementation">Feature Implementation</a></li>
        <li><a href="#areas-of-improvement">Areas of Improvement</a></li>
      </ol>
  </ol>
</details>


## About The Project

This is my submission for The Motley Fool's FOLD Developer Interview Project. This repo was forked from a [Todo-Backend](http://www.todobackend.com/index.html) submission, [Rails 5 API-only](https://github.com/doerfli/todo-backend-rails5-api). An RSpec test suite was built that achieves 100% test coverage. All features were built with Test Driven Development in under 2 hours.

### Built With

* [Rails](https://rubyonrails.org/)
* [MongoDB](https://www.mongodb.com/)
* [RSpec](https://rspec.info/)
* [Simplecov](https://github.com/simplecov-ruby/simplecov)


## Getting Started

### Install Locally

Environment Notes:

If you haven't installed MongoDB, [this guide will help](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/).

This project uses Ruby 2.6.3. The Ruby version can be set locally using [rbenv](https://github.com/rbenv/rbenv).

1. Fork and Clone the repo
   ```
   git clone https://github.com/aidenmendez/todo-backend-rails5-api
   cd todo-backend-rails5-api
   ```
2. Install gems
   ```
   bundle install 
   ```
3. Run tests
   ```
   bundle exec rspec
   ```
4. View coverage report
   ```
   open coverage/index.html
   ```

## The Process

### Initial Thoughts
Originally I planned to build this project using Ruby on Rails and PostgreSQL. However, once I realized the repositories that offered this combination were either deprecated or no longer exist, I decided to use doerfli's [Rails 5 API-only](https://github.com/doerfli/todo-backend-rails5-api) submission, which uses Rails and MongoDB. I had never worked with a NoSQL database, so I spent a little bit of time deep diving into the [MongoDB documentation](https://docs.mongodb.com/) before getting started.

Aside from implementing the new features listed below, I also spent about twenty minutes building out feature and model tests for the app's preexisting functionality. While this wasn't a requirement, it was important to ensure the API was working properly since the it was also failing the [Todo-Backend spec harness](http://www.todobackend.com/specs/index.html?https://todo-backend-rails5-api.herokuapp.com/todos).

### Feature Implementation
I rely on To Do lists everyday to stay organized. I keep a _Today_ and a _Next Week_ section in my paper planner, so I wanted to emulate this design by implementing a _Due Date_ feature. After adding a `due_date` field to the ToDos model, I built three new endpoints:

- `today`: Returns all incomplete tasks that are due by the end of the current day.
- `future`: Returns all incomplete tasks due after the current day.
- `all_today`: Returns all complete and incomplete tasks due by the end of the current day.

Rails uses the [mongoid](https://github.com/mongodb/mongoid) ODM for MongoDB, which I found to be pretty similar to ActiveRecord. I also opted to use the `mongoid-rspec` gem to add useful matchers for model testing.

### Areas of Improvement
Implementing these changes took me just under 2 hours. Here are some improvements I'd make given more time:

- Sort the endpoint responses by either `created_at` (for `today`/ `all_today`) or `due_date` (`future` endpoint).
- Add a `date_range` parameter to the `future` endpoint so tasks due in a given timeframe can be requested.
- Implement a serializer such as [Fast JSON API](https://github.com/Netflix/fast_jsonapi) rather than just rendering responses in JSON. (This was part of the app's original design so I stuck with it).
