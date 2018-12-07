require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # 默认已经加载同名固件，如果名字不匹配，可以通过下面这样手动指定固件名称
  # fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "My Book Title",
                          description: "yyy",
                          image_url: "zz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "image url must be valid" do
    ok = '123.jpg'
    bad = 'dsad.txt'

    assert new_product_with_image_url(ok).valid?, "#{ok} shouldn't be invalid"
    assert new_product_with_image_url(bad).invalid?, "#{bad} shouldn't be valid"
  end

  private
  def new_product_with_image_url(image_url)
    Product.new(title: 'dsad',
                description: 'dsadsa',
                price: 1.00,
                image_url: image_url)
  end
end
