# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

products = Product.create([
  { code: 'VOUCHER', name: 'Cabify Voucher', price: 5.00 },
  { code: 'TSHIRT', name: 'Cabify T-Shirt', price: 20.00 },
  { code: 'MUG', name: 'Cabify Coffee Mug', price: 7.50 }
])

voucher = Product.first

voucher.discount = Discount.create(type_discount: 1, min_products: 2, products_pay: 1)

tshirt = Product.second

tshirt.discount = Discount.create(type_discount: 2, min_products: 3, price_unit: 19.00)