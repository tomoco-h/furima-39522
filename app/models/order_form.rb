class OrderForm 
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :municipalities, :street_address, :building_name, :phone, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_code
    validates :post_code,       format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id
    validates :prefecture_id,   numericality: {other_than: 1, message: "can't be blank"}
    validates :municipalities
    validates :street_address
    validates :phone
    validates :phone,           format: { with: /\A\d{10,11}\z/,message: "is invalid. Include hyphen(-)"}
    validates :token
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipalities: municipalities, street_address: street_address, building_name: building_name, phone: phone, order_id: order.id)
  end
end