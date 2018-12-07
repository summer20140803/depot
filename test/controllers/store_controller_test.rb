require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    # 用于验证 store_index_url 对应的视图请求是否成功
    get store_index_url
    assert_response :success

    # 用于检测侧边栏是否有4个链接
    assert_select '#columns #side a', minimum: 4
    # 用于检测是否拥有3个产品
    assert_select '#main .entry', 3
    # 用于检测是否拥有title为szy的产品
    assert_select 'h3', 'szy'
    # 用于检测产品价格是否符合$xxx.xx的规格
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

end
