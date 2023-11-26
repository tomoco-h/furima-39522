class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :charge
  belongs_to :prefecture
  belongs_to :shipping

  validates :name,          presence: true, length: {minimum: 1, maximum: 40}
  validates :explanation,   presence: true, length: {minimum: 1, maximum: 1000} 
  validates :category_id,   numericality: { other_than: 1 }
  validates :condition_id,  numericality: { other_than: 1 }
  validates :charge_id ,    numericality: { other_than: 1 }
  validates :prefecture_id, numericality: { other_than: 1 }
  validates :shipping_id,   numericality: { other_than: 1 }
  validates :price,         presence: true
  validates :price,         numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                            format: { with: /\A[0-9]+\z/ }
  validates :image,         presence: true
end