module DynamicPageLookup
  def method_missing(meth, *args, &block)
    if page?(meth) && args.empty?
      page_object_for(meth)
    else
      super
    end
  end

  def page_object_for(page_name)
    class_name = page_name.to_s.camelize
    class_name.constantize.new
  rescue NameError => e
    raise "No page defined with name #{class_name}"
  end

  def page?(meth)
    meth =~ /_page$/
  end
end

class Page
  include Capybara::DSL
  include Rails.application.routes.url_helpers
  include DynamicPageLookup
end

RSpec.configure do |config|
  config.include DynamicPageLookup, type: :feature
end
