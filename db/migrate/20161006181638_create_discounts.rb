class CreateDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :discounts do |t|
      t.integer :type_discount
      t.integer :min_products
      t.integer :products_pay
      t.float :price_unit
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
