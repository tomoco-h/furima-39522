class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :charge, :prefecture, :shipping

  validates :name,          presence: true
  validates :explanation,   presence: true
  validates :category_id,   numericality: { other_than: 1 }
  validates :condition_id,  numericality: { other_than: 1 }
  validates :charge_id ,    numericality: { other_than: 1 }
  validates :prefecture_id, numericality: { other_than: 1 }
  validates :shipping_id,   numericality: { other_than: 1 }
  validates :price,         presence: true
  validates :image,         presence: true
end