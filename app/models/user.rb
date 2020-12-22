class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, presense: true
  validates :last_name, presense: true
  validates :first_name, presense: true
  validates :last_name_kana, presense: true
  validates :fitst_name_kana, presense: true
  validates :birthday, presense: true
  
end
