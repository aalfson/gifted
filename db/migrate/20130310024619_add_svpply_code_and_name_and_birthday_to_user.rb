class AddSvpplyCodeAndNameAndBirthdayToUser < ActiveRecord::Migration
  def change
    add_column :users, :svpplyCode, :string
    add_column :users, :name, :string
    add_column :users, :birthday, :date
  end
end
