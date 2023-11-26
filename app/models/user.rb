class User < ApplicationRecord
  GOLD_TIER = 50000
  SILVER_TIER = 10000
  BRONZE_TIER = 0

  has_many :orders, class_name: 'Order', foreign_key: 'customer_id'

  before_create do
    self.tier = 'bronze'
  end
end
