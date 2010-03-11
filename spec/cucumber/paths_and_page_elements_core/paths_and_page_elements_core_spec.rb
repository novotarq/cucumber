require File.dirname(__FILE__) + '/../../spec_helper'
require 'cucumber/paths_and_page_elements_core/paths_and_page_elements_core'

module Cucumber
  module PathsAndPageElementsCore

    describe PathsAndPageElements do

      it "does a block of code for Regexp" do
        paths = PathsAndPageElements.new
        #paths.Put /^I am simple step$/ ,:path,do "simple" end
        #paths.exec_block("I am simple step", :path).should == "simple"
      end

    end

  end
end