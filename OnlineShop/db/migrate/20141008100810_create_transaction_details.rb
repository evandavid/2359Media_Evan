class CreateTransactionDetails < ActiveRecord::Migration
  def change
    create_table :transaction_details do |t|
      t.integer :transaction_id
      t.integer :product_id
      t.integer :amount

      t.timestamps
    end
    add_index :transaction_details, :transaction_id
    add_index :transaction_details, :product_id
  end
end
