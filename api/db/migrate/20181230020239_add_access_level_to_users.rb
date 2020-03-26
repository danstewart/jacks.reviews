class AddAccessLevelToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :access_level, :integer, after: :email
  end
end
