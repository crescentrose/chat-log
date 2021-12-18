class CreateFlags < ActiveRecord::Migration[6.1]
  def change
    create_table :flags do |t|
      t.belongs_to :message, null: false, foreign_key: true
      t.string :reason, null: false
      t.string :resolve_token, null: false
      t.string :discord_webhook_id
      t.timestamp :resolved_at

      t.timestamps
    end
  end
end
