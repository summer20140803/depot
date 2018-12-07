require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @update = {
        description: 'my random description',
        image_url: 'adrpo.jpg',
        price: 32.95,
        title: 'random title'
    }
  end

  test "should get index" do
    # 用于验证 products_url 对应的视图请求是否成功
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: @update }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: @update }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    # 预期该产品能被删除，所以Product.count会-1
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "can't delete product in cart" do
    # 预期产品two因为被多个购物车商品关联，所以会删不了，所以此处为0
    # 此处其实是在校验Product模型的 ensure_not_referenced_by_any_line_item 钩子方法
    assert_difference('Product.count', 0) do
      delete product_url(products(:two))
    end

    assert_redirected_to products_url
  end

end
