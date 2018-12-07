class Product < ApplicationRecord
  # 这里使用has_many的原因是可能存在多个购物车，就会出现多个商品引用一个产品的情况
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  # 确保标题是唯一的
  validates :title, uniqueness: true
  # 确保价格是有效数字且大于等于0.01元
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  # 确保图片路径是以gif/jpg/png结尾的，allow_blank防止与presence验证重复报错
  validates :image_url, allow_blank: true, format: {
      with: %r(\.(gif|jpg|png)\Z)i,
      message: 'must be a URL for GIF, JPG or PNG image.'
  }

  private

  # 确保没有商品仍在引用此产品
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end

end
