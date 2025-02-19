class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :integer, default: 0, null: false
    add_column :users, :full_name, :string, null: false
    add_column :users, :birthdate, :date, null: false
    add_column :users, :active, :boolean, default: true, null: false
  end
end
