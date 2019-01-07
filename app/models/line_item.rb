class LineItem < ApplicationRecord
  # optional选项表明，不会验证关联的对象是否存在
  belongs_to :product, optional: true
  belongs_to :order, optional: true
  belongs_to :cart

  def total_price
    price * quantity
  end
end
