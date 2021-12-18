class DropFlaggedAtFromMessages < ActiveRecord::Migration[6.1]
  def change
    remove_column :messages, :flagged_at, :timestamp
  end
end
