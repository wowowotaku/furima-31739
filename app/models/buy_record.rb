class BuyRecord < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :send_to
end
