class Item < ApplicationRecord

  belongs_to :user
  has_one :buy_record
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :day
  belongs_to_active_hash :from
  belongs_to_active_hash :shippingfee
  belongs_to_active_hash :status

  with_options presence: true do
    validates :item_name
    validates :category_id
    validates :explain
    validates :price
    validates :status_id
    validates :shippingfee_id
    validates :from_id
    validates :day_id
    validates :image
  end

  with_options numericality: { other_than: 1 } do 
    validates :category_id
    validates :status_id
    validates :shippingfee_id
    validates :from_id
    validates :day_id
  end
end
