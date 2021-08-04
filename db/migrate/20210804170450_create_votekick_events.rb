class CreateVotekickEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :votekick_events do |t|
      t.string :initiator_steamid3
      t.string :target_steamid3
      t.string :target_name
      t.timestamp :time
      t.references :server, null: false, foreign_key: true

      t.timestamps
    end

    add_index :votekick_events, :initiator_steamid3
    add_index :votekick_events, :target_steamid3
    add_index :votekick_events, :target_name
  end
end
