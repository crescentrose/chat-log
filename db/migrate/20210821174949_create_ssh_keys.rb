class CreateSSHKeys < ActiveRecord::Migration[6.1]
  def change
    create_table :ssh_keys do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.text :private_key

      t.timestamps
    end
  end
end
