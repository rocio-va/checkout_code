require 'rails_helper'

RSpec.describe Discount, type: :model do
  before(:each) do
    @product_voucher = Product.create(code: 'VOUCHER', name: 'Cabify Voucher', price: 5.00 )
    @product_voucher.discount = Discount.create(type_discount: 1, min_products: 2, products_pay: 1)
    @product_tshirt = Product.create(code: 'TSHIRT', name: 'Cabify T-Shirt', price: 20.00)
    @product_tshirt.discount = Discount.create(type_discount: 2, min_products: 3, price_unit: 19.00)

  end
  
  describe "check_discount_voucher" do
    it "amount is 0 you pay 0" do
      amount = 0
      expect(@product_voucher.discount.calculate_price(amount)).to eql(0.0) 
    end

    it "amount is 2 you pay 1" do
      amount = 2
      expect(@product_voucher.discount.calculate_price(amount)).to eql(@product_voucher.price)
    end

    it "amount is 7 you pay 4" do
      amount = 7
      expect(@product_voucher.discount.calculate_price(amount)).to eql(@product_voucher.price * 4)
    end
  end
  describe "check_discount_tshirt" do
    it "amount is 0 you pay 0" do
      amount = 0
      expect(@product_tshirt.discount.calculate_price(amount)).to eql(0.0) 
    end

    it "amount is 2 you pay 2" do
      amount = 2
      expect(@product_tshirt.discount.calculate_price(amount)).to eql(@product_tshirt.price * 2)
    end 

    it "amount is 7 you pay less per unit (19)" do
      amount = 7
      expect(@product_tshirt.discount.calculate_price(amount)).to eql(@product_tshirt.discount.price_unit * 7)
    end
  end

end