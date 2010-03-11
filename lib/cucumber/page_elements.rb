require 'cucumber/page_elements/page_element_matcher'

module Cucumber
  module PageElements
  end
end

module Kernel
  def PageElement (regexp, &block)
    Cucumber::PageElements.PageElement(regexp, &block)
  end
  
  def match_element(str)
    Cucumber::PageElements.match_element str
  end
end
