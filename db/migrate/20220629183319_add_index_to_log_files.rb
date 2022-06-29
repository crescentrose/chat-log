class AddIndexToLogFiles < ActiveRecord::Migration[7.0]
  def change
    add_index :log_files, :status
  end
end
