class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,        presence: true
  validates :password,        format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)/, message: "is invalid. Include both letters and numbers"}
  validates :last_name,       presence: true
  validates :last_name,       format: { with: /\A[ぁ-んァ-ン一-龯]+\z/, message: "is invalid. Input full-width characters" }
  validates :first_name,      presence: true
  validates :last_name,       format: { with: /\A[ぁ-んァ-ン一-龯]+\z/, message: "is invalid. Input full-width characters" }
  validates :last_name_kana,  presence: true
  validates :last_name_kana,  format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters" }
  validates :first_name_kana, presence: true
  validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters" }
  validates :birthday,        presence: true
end
