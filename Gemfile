source "https://rubygems.org"

ruby "3.4.1"
gem "rails", "~> 8.0.1"

gem "pg"
gem "activerecord-postgis-adapter"
gem "puma", ">= 5.0"
gem "bootsnap", require: false
gem "ostruct"

gem "rack-attack"
gem "dry-struct"
gem "dry-types"
gem "ransack"
gem "kaminari"

gem "jsonapi-serializer"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  gem "brakeman", require: false

  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-json_expectations"
end
