class Checkout 
  
  def initialize
    #hash to keep products
    @products = {}
  end

  def scan(code)
    #check if the product exists
    if(Product.find_by(code: code))
      code_key = code.to_sym
      if(@products.has_key?(code_key))
        @products[code_key] = @products[code_key] + 1
      else
        @products[code_key] = 1
      end
    else
      #if product doesn't exist return false
      false
    end
  end

  def total
    total_price = 0
    @products.each do |key, value|
      product = Product.find_by(code: key)
      amount = value
      if(product.discount)
        total_price = total_price + product.discount.calculate_price(amount)
      else
        total_price = total_price + product.price * amount
      end
    end
    total_price
  end

end