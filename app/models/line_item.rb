class LineItem < ApplicationRecord
  belongs_to :item
  belongs_to :order_item, optional: true
 
end