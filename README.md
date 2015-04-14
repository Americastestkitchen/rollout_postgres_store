# RolloutPostgresStore
[![Build Status](https://travis-ci.org/Americastestkitchen/rollout_postgres_store.svg)](https://travis-ci.org/Americastestkitchen/rollout_postgres_store)
[![Code Climate](https://codeclimate.com/github/Americastestkitchen/rollout_postgres_store/badges/gpa.svg)](https://codeclimate.com/github/Americastestkitchen/rollout_postgres_store)
[![Test Coverage](https://codeclimate.com/github/Americastestkitchen/rollout_postgres_store/badges/coverage.svg)](https://codeclimate.com/github/Americastestkitchen/rollout_postgres_store)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rollout_postgres_store'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rollout_postgres_store

## Dependencies

This gem relies on Postgres' Hstore extension and the Rollout gem. You will need  
Gems:
- active_record >= 4.0.0
- rollout >= 2.0.0
- pg 

Postgres >= 9.2

## Usage

To use this gem, you will need to have an ActiveRecord model with a hstore 
attribute. Once you have that, you should add the following inside of
`config/initializers/rollout.rb`:

```
# FeatureFlag is the model that has your Hstore attribute.
# 'data' is the hstore attribute on your FeatureFlag model.
ROLLOUT = Rollout.new(RolloutPostgresStore.new(FeatureFlag, 'data'))
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rollout_postgres_store/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
