require 'active_record'
require 'database_cleaner'

begin
  ActiveRecord::Base.establish_connection({
    'adapter' => 'postgresql',
    'host' => 'localhost'
  }).connection.create_database('rollout_store_test')
rescue ActiveRecord::StatementInvalid
end

conn = ActiveRecord::Base.establish_connection({
  'database' => 'rollout_store_test',
  'adapter' => 'postgresql',
  'host' => 'localhost'
})

if !conn.connection.tables.include?('feature_flags')
  load File.dirname(__FILE__) + '/support/schema.rb'
end

load File.dirname(__FILE__) + '/support/models.rb'

DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :transaction
