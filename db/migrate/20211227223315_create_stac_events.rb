class CreateStACEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :stac_events do |t|
      t.text :message, null: false
      t.belongs_to :server, null: false, foreign_key: true
      t.string :player_steamid3

      t.timestamps
    end
  end
end
