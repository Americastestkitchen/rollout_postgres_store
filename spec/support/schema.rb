ActiveRecord::Schema.define do
  self.verbose = false

  execute "CREATE EXTENSION hstore"
  create_table :feature_flags, :force => true do |t|
    t.hstore :data
    t.timestamps
  end
end
