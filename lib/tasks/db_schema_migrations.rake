# 自定义rake任务，例如打印出执行过的全部迁移的版本号
namespace :db do
  desc "Prints the migrated versions"
  task :schema_migrations => :environment do
    puts ActiveRecord::Base.connection.select_values(
        'select version from schema_migrations order by version'
    )
  end
end