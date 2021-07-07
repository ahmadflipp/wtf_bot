# Wtf Bot

| Branch  | Status |
|---------|--------|
| main  | [![CircleCI](https://circleci.wishabi.com/gh/wishabi/wtf_bot/tree/main.svg?style=svg&circle-token=526178bf3bfc819d97a3bb6698d5eabbfec0f8bc)](https://circleci.wishabi.com/gh/wishabi/wtf_bot/tree/main) |

Add documentation for your project here.

## Table of Contents

* [Overview](#overview)
* [Quick Links](#quick-links)
* [Architecture](#architecture)
* [Tech Stack](#tech-stack)
* [Directory Structure](#directory-structure)
* [Local Setup](#local-setup)
* [Todo](#todo)
* [Metrics](#metrics)

## Overview

Describe your service here.

## Quick Links

|   | Production | Staging |
|---|:----------:|:-------:|
| PrimeRadiant | [wtf_bot](https://prime-radiant.flippback.com/services/wtf_bot/services-ecs-prod) | [wtf_bot-stg](https://prime-radiant.flippback.com/services/wtf_bot-stg/services-ecs-stg) |
| CircleCI | [main Branch](https://circleci.wishabi.com/gh/wishabi/wtf_bot/tree/main) | [Staging Branch](https://circleci.wishabi.com/gh/wishabi/wtf_bot/tree/staging) |  |
| Datadog Dashboard | `TODO` | `TODO` |

## Architecture

Add links to architecture diagrams here.

### Tech Stack

* Docker & Docker Compose
* Ruby 2.7: [Gem list](Gemfile)
* Rails 6

## Directory Structure

```Text
/.circleci            # CircleCI configuration
/app                  # Core application code
  /models             # Virtus models for produced topics
  /schemas            # Avro schemas for produced and consumed messages
/bin                  # Bundle, Rails, and Rake setups
/config               #
  /environments       # Rails environment configuration
  /initializers       # Rails initializers & config
  /settings           # Application settings configuration
/datadog              # Datadog configuration
/deploy               # Deployment scripts
/one-for-all          # One-For-All scripts
/one_click_dev        # Misc convenience scripts e.g. for compiling schemas, publishing to kafka, etc.
/spec                 # RSpec unit tests
```

## Local Setup

First [install RVM](https://rvm.io/rvm/install).

Finally, run `bin/setup` to get your environment set up for development.

You can use `gdc` to manage your app dependencies. For more information on using `gdc`, please see [global_docker_compose](https://github.com/wishabi/global-docker-compose).

## Linting

Ruby `rubocop -a` to fix any auto-fixable offenses which would fail the lint step in CircleCI.
You can run `rubocop -A` to fix offenses that may be "unsafe". Most of the time the "unsafe"
part is pretty extreme edge cases, so you can try using `-A` as your default.

## Todo
To get your service up and running you may need to take the following steps:

### Prime Radiant
Change the Tasks / ELB Health Check Endpoint on your service to be `/ping` so
that your service is not thought to be unhealthy and reset repeatedly.

Set a Prime Radiant secret param for SECRET_KEY_BASE. Generate this key using
`rails secret`. See `config/secrets.yml`.


  ### RDS
  Request a RDS database by filing an Eng Cap ticket - and make sure the
  - `DB_PASSWORD` is in Prime Radiant Param Store
  - `DB_HOST` is a set ENV variable in Prime Radiant
  - The service database username is current in `config/database.yml`
  
  If you need to create these users yourself, do the following:
  * [Install the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
  * Use SSM to access gw2:
  
  ```
  aws ssm start-session --target i-04218d
  ```
  
  * Use MySQL to create the user (auto-generate a password using a site like
  [passwordsgenerator.net](https://passwordsgenerator.net/):
  
  ```
  mysql -uadmin -p -h {rds_instance} <%= app_name %>_production
  > create user <%= app_name %>  identified by '{password}';
  > grant all on <%= app_name %>_production to <%= app_name %>;
  ```

## Metrics

### Datadog Dashboards as Code
The Datadog dashboard for this repo is generated via code, which can be found in the `./datadog` folder.

***IMPORTANT: Modifications to the dashboard must be made in code.
If changes are made manually via the Datadog webapp, then those changes will be blown away and overwritten
the next time this application is deployed.***
