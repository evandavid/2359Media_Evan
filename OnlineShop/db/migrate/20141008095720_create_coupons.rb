class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :product_id
      t.string :coupon
      t.boolean :is_active

      t.timestamps
    end
    add_index :coupons, :product_id
  end
end
