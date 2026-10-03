namespace :db do
  namespace :solid do
    # On Render the cache/queue/cable configs all point at the single primary
    # database (see config/database.yml). Their tables come from db/*_schema.rb,
    # not migrations, and db:prepare skips loading those schemas once the shared
    # database already has schema_migrations. Load them here when missing.
    desc "Load Solid Cache/Queue/Cable schemas into the shared database if their tables are missing"
    task prepare: :environment do
      { cache: "solid_cache_entries", queue: "solid_queue_jobs", cable: "solid_cable_messages" }.each do |name, table|
        db_config = ActiveRecord::Base.configurations.configs_for(env_name: Rails.env, name: name.to_s)
        next unless db_config
        next if ActiveRecord::Base.connection.table_exists?(table)

        ActiveRecord::Tasks::DatabaseTasks.load_schema(db_config, :ruby)
        puts "Loaded #{name} schema from #{db_config.schema_dump}"
      end
    end
  end
end
