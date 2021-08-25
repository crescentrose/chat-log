class AddFlagsToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :flagged_at, :timestamp
  end
end
