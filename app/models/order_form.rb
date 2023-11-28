class OrderForm 
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :municipalities, :street_address, :building_name, :phone

  validates :item_id,         presence: true
  validates :user_id,         presence: true
  validates :post_code,       presence: true
  validates :post_code,       format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :prefecture_id,   presence: true
  validates :prefecture_id,   numericality: {other_than: 0, message: "can't be blank"}
  validates :municipalities,  presence: true
  validates :street_address,  presence: true
  validates :phone,           presence: true
  validates :phone,           format: { with: /\A\d{10,11}\z/,message: "is invalid. Include hyphen(-)"}

  def save(params, user_id)
    order = Order.create(item_id, params[:item_id].to_i, user_id: user_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipalities: municipalities, street_address: street_address, building_name: building_name, phone: phone, order_id: order_id)
  end
end