class Order < ApplicationRecord
  belongs_to :customer, class_name: 'User'
end
