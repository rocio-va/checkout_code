# README



* Ruby version

* System dependencies

* Configuration

* Database creation

  Models: 

    Product 
      Fields: code, name and price 
      Relation has_one Discount

    Discount
      Fields: type_discount, min_products, products_pay, price_unit and product_id
      Relation belongs_to Product
      type_discount suggest the type, in this case can be
        1, discounts like 2x1, 3x2...
        2, discounts buy more pay less like buy 3 or more and pay 19 per unit
      min_products indicates the minimum amount of product to apply the discount
      products_pay (only for type 1) indicates the amount you pay per min_products
      price_unit (only for type 2) indicates the price per unit if you buy min_products or more
      product is a reference to the product that discount apply (in this case one product can only have one discount)

    Checkout
      This model don't have a migration, at this moment it can only use it if you have a instance in session. When I have User model and User has_one Checkout I will add a relations with Checkout belongs_to User and Checkout has_many Products
      Checkout's constructor receives an array as parameter, that array has the ids of the discounts to apply to that checkout


* Database initialization
  rake db:create db:migrate db:seed
  pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start

* How to run the test suite

  Model Discount
  bundle exec rspec spec/models/discount_spec.rb
  Model Checkout
  bundle exec rspec spec/models/checkout_spec.rb

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
