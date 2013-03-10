class AddSvpplyUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :svpplyUserId, :string
  end
end
