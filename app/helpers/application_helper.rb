module ApplicationHelper
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end

    unless options[:renderer]
      options = options.merge :renderer => MyCustomLinkRenderer
    end

    super *[collection_or_options, options].compact
  end

  def active_class?(path)
    :active if current_page?(path)
  end
end


class MyCustomLinkRenderer < WillPaginate::ActionView::LinkRenderer
  def page_number(page)
    tag :li, link(page, page), :rel => rel_value(page),
      :class => (page == current_page) ? :active : ''
  end

  def previous_or_next_page(page, text, classname)
    tag :li,
        link(text, page),
        class: "#{classname} #{page ? '' : :disabled}"
  end

  def html_container(html)
    tag(:div, tag(:ul, html, class: :pagination), container_attributes)
  end

  def gap
    tag :li, '<span class="gap">&hellip;</span>'
  end
end
