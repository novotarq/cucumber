module Kernel
  def Path (regexp, &proc)
    Cucumber::PathsAndPageElementsCore.Put(regexp, :path, &proc)
  end
  def path_to (input)
    Cucumber::PathsAndPageElementsCore.exec_block(input, :path)
  end
end