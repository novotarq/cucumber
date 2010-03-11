require File.dirname(__FILE__) + '/../../spec_helper'
require 'cucumber/paths_and_page_elements_core/paths_and_page_elements_core'

module Cucumber
  module PathsAndPageElementsCore

    describe PathsAndPageElements do

      it "should allow to register the same step names for path and page element" do
        Path "I am simple step for registration test" do "simple" end
        PageElement "I am simple step for registration test" do "simple" end
      end

    end

  end
end