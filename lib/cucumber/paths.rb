require 'cucumber/paths/path_resolver'

module Cucumber
  module Paths
  end
end

module Kernel
  def Path (regexp, &proc)
    Cucumber::Paths.Path(regexp, &proc)
  end
  def path_to (input)
    Cucumber::Paths.path_to(input)
  end
end