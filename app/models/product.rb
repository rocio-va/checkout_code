class Product < ApplicationRecord
  
  validates :code, uniqueness: true

  has_one :discount, dependent: :destroy

end
