module ApplicationHelper
  def form_group_tag(errors, &block)
     css_class = 'form-group'
     css_class << ' has-error' if errors.any?
     content_tag :div, capture(&block), class: css_class
  end

  def shift_length(clock_in, clock_out)
    ti = clock_in.to_time
    to = clock_out.to_time
    tt = ((to - ti) / 1.hour)
  end
end
