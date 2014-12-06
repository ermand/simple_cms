module ApplicationHelper

  def status_tag(boolean, options={})
    options[:true_text] ||= 'YES'
    options[:false_text] ||= 'NO'

    if boolean
      content_tag(:span, options[:true_text], :class => 'label label-success')
    else
      content_tag(:span, options[:false_text], :class => 'label label-danger')
    end
  end

end
