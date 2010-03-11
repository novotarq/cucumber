module Kernel
  def PageElement (regexp, &block)
    Cucumber::PathsAndPageElementsCore.Put(regexp, :page_element, &block)
  end
  
  def match_element(str)
    Cucumber::PathsAndPageElementsCore.exec_block(str, :page_element)
  end
end
