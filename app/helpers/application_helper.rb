module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes['style'] = "display: none"
    end
    # content_tag视图辅助方法用于把块生成的输出包装在指定的标签中
    content_tag('div', attributes, &block)
  end
end
