class Discount < ApplicationRecord

  validates :type_discount, presence: true

  belongs_to :product

  def calculate_price(amount)
    case self.type_discount
      when 1
        #case 1 type of discount one free (3x2, 2x1...)
        one_free(amount)
      when 2
        #case 2 type of discount buy more pay less (buy 3 or more and pay 19 instead of 20 per unit)
        buy_more(amount)
      else
        false
    end
  end

  private

    def one_free(amount)
      #first addend: amount of products to pay (don't care about min)
      #second addend: amount to reach a multiple of min_products
      (((amount / self.min_products) * self.products_pay) + (amount % self.min_products)) * self.product.price
    end

    def buy_more(amount)
      if(amount >= min_products)
        amount * price_unit
      else
        amount * self.product.price
      end
    end

end
