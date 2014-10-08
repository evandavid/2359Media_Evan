class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :amount
      t.boolean :success
      t.text :note

      t.timestamps
    end
  end
end
