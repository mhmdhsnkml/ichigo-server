class User < ApplicationRecord
  has_many :orders, class_name: 'Order', foreign_key: 'customer_id'

  before_create do
    self.tier = 'bronze'
  end
end
