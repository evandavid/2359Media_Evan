class AddDetailToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :debit_card_number, :string
    add_column :users, :expiry, :date
  end
end
