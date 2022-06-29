class AddStatusToLogFiles < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE log_file_status AS ENUM ('new', 'processing', 'processed', 'error')
    SQL
    add_column :log_files, :status, :log_file_status, null: false, default: 'new'
  end

  def down
    remove_column :log_files, :status
    execute <<-SQL
      DROP TYPE log_file_status;
    SQL
  end
end
