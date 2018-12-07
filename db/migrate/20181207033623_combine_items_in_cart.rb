class CombineItemsInCart < ActiveRecord::Migration[5.2]
  def up
    # 把购物车中同一个产品的多个商品替换为单个商品
    Cart.all.each do |cart|
      # 计算购物车中每个产品的数量
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          # 删除同一个产品的多个商品
          cart.line_items.where(product_id: product_id).delete_all

          # 替换为单个商品
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    # 把数量大于1的商品分割为多个商品
    LineItem.where("quantity>1").each do |line_item|
      line_item.quantity.times do
        # create操作已经包含了new和save操作，会自动存入数据库
        LineItem.create(
           cart_id: line_item.cart_id,
           product_id: line_item.product_id,
           quantity: 1
        )
        # 删除原来的数量大于1的商品
        line_item.delete
      end
    end
  end
end
