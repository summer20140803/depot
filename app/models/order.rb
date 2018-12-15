class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  enum pay_type: {
      "Check"          => 0,
      "Credit card"    => 1,
      "Purchase order" => 2
  }

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      # 这里不需要手动设置item的order_id属性
      # 只要注明了line_item和order的双向关系(has_many和belongs_to)，就可以由Rails来完成
      line_items << item
    end
  end
end
