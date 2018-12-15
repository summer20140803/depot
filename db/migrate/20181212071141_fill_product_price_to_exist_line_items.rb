class FillProductPriceToExistLineItems < ActiveRecord::Migration[5.2]
  def change
    LineItem.all.each do |item|
      if item.price.nil?
        product = Product.find(item.product_id)
        item.price = product.price
        item.save!
      end
    end
  end
end
