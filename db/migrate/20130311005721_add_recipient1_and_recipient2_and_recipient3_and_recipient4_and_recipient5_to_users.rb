class AddRecipient1AndRecipient2AndRecipient3AndRecipient4AndRecipient5ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recipient1, :string
    add_column :users, :recipient2, :string
    add_column :users, :recipient3, :string
    add_column :users, :recipient4, :string
    add_column :users, :recipient5, :string
  end
end
