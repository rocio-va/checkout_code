require 'rails_helper'
require './app/models/checkout'

RSpec.describe Checkout, type: :model do
  before(:each) do
    @product_voucher = Product.create(code: 'VOUCHER', name: 'Cabify Voucher', price: 5.00 )
    @product_tshirt = Product.create(code: 'TSHIRT', name: 'Cabify T-Shirt', price: 20.00)
    @product_mug = Product.create(code: 'MUG', name: 'Cabify Coffee Mug', price: 7.50) 
    @product_voucher.discount = Discount.create(type_discount: 1, min_products: 2, products_pay: 1)
    @product_tshirt.discount = Discount.create(type_discount: 2, min_products: 3, price_unit: 19.00)
    @discounts = [@product_voucher.discount.id, @product_tshirt.discount.id]
    @checkout = Checkout.new(@discounts)
  end
  
  describe "check_total_checkout" do
    it "Items: VOUCHER, TSHIRT, MUG --> Total: 32.50€" do
      @checkout.scan('VOUCHER')
      @checkout.scan('TSHIRT')
      @checkout.scan('MUG')
      expect(@checkout.total).to eql(32.50) 
    end

    it "Items: VOUCHER, TSHIRT, VOUCHER --> Total: 25.00€" do
      @checkout.scan('VOUCHER')
      @checkout.scan('TSHIRT')
      @checkout.scan('VOUCHER')
      expect(@checkout.total).to eql(25.00)
      end

    it "Items: TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT --> Total: 81.00€" do
      @checkout.scan('TSHIRT')
      @checkout.scan('TSHIRT')
      @checkout.scan('TSHIRT')
      @checkout.scan('VOUCHER')
      @checkout.scan('TSHIRT')
      expect(@checkout.total).to eql(81.00)
    end

    it "Items: VOUCHER, TSHIRT, VOUCHER, VOUCHER, MUG, TSHIRT, TSHIRT --> Total: 74.50€" do
      @checkout.scan('VOUCHER')
      @checkout.scan('TSHIRT')
      @checkout.scan('VOUCHER')
      @checkout.scan('VOUCHER')
      @checkout.scan('MUG')
      @checkout.scan('TSHIRT')
      @checkout.scan('TSHIRT')
      expect(@checkout.total).to eql(74.50)
    end
  end

end