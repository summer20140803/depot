# 这里可以存放一些全局的自定义的视图辅助方法，如若只是专用视图用，请放到对应模块的 *_helper.rb文件中
module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes['style'] = "display: none"
    end
    # content_tag视图辅助方法用于把块生成的输出包装在指定的标签中
    content_tag('div', attributes, &block)
  end
end
