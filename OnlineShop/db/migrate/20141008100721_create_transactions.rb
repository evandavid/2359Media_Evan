class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.boolean :done
      t.string :fee

      t.timestamps
    end
    add_index :transactions, :user_id
  end
end
