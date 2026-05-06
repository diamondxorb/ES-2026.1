# features/support/rails.rb
require 'cucumber/rails'

# Capybara defaults to CSS3 selectors rather than XPath.
# If you'd prefer to use XPath, just uncomment this line and adjust any
# selectors in your step definitions to use the XPath syntax.
# Capybara.default_selector = :xpath

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how
# your application behaves in the production environment, where an error page will
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For Rails 8, database_cleaner is not needed as Rails handles it.
# If you need it, uncomment:
# require 'database_cleaner'
# DatabaseCleaner.strategy = :truncation

# You may also want to configure DatabaseCleaner to use different strategies for certain features/scenarios.
# See the DatabaseCleaner documentation for details. Example:
# Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#   DatabaseCleaner.strategy = :truncation
# end
#
# Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
#   DatabaseCleaner.strategy = :transaction
# end

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
# DatabaseCleaner.strategy = :transaction