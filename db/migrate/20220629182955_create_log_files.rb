class CreateLogFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :log_files do |t|
      t.references :server, null: false, foreign_key: true
      t.string :map_name, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
