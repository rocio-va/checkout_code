class Checkout 
  
  def initialize(pricing_rules)
    #pricing_rules(parameter) is an array with ids of discounts to apply to this checkout
    #hash to keep products
    @products = {}
    #@pricing_rules is a hash
    @pricing_rules = load_discounts(pricing_rules)
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
      if(@pricing_rules[key])
        #if the checkout have discount to this product
        total_price = total_price + @pricing_rules[key].calculate_price(amount)
      else
        total_price = total_price + product.price * amount
      end
    end
    total_price
  end

  private

    def load_discounts(pricing_rules)
      discounts = {}
      pricing_rules.each do |discount_id|
        discount = Discount.find_by(id: discount_id)
        if(discount)
          code_product = discount.product.code.to_sym
          discounts[code_product] = discount
        end
      end
      discounts
    end

end