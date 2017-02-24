class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  enum status: ['ordered', 'paid', 'canceled', 'completed']

  
end
