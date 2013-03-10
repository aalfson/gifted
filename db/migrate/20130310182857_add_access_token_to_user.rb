class AddAccessTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :accessToken, :string
  end
end
