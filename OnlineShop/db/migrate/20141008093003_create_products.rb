class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :price
      t.string :quantity
      t.string :image

      t.timestamps
    end
  end
end
