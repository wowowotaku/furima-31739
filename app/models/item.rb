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
  has_one_attatched :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :day
  belongs_to_active_hash :from
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :status
end
