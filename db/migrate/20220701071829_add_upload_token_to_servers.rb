class AddUploadTokenToServers < ActiveRecord::Migration[7.0]
  def change
    add_column :servers, :upload_token, :string
  end
end
