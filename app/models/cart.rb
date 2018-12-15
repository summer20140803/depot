class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      # 下面的方法等同于 current_item = LineItem.new(product_id: product.id, cart_id: self.id)
      current_item = self.line_items.build(product_id: product.id)
      current_item.price = product.price
    end
    current_item
  end

  def total_price
    # line_items返回的对象是 <LineItem::ActiveRecord_Associations_CollectionProxy:0x00007fb946ea8d58>
    # 需要通过 #to_a 转换成Ruby数组
    line_items.to_a.sum do |item|
      logger.error "#{item}"
      item.total_price
    end
  end
end
