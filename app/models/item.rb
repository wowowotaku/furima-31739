class Item < ApplicationRecord

  with_options presence: true do
    validates :item_name
    validates :category_id
    validates :explain
    validates :price
    validates :status_id
    validates :shipping_fee_id
    validates :from_id
    validates :day_id
  end
  
  belongs_to :user
  has_one :buy_record
  
end
