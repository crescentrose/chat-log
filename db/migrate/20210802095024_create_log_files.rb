class CreateLogFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :log_files do |t|
      t.references :server, null: false, foreign_key: true
      t.boolean :processed, null: false, default: false

      t.timestamps
    end
  end
end
