require File.dirname(__FILE__) + '/../../spec_helper'
require 'cucumber/page_elements'

module Cucumber
  module PageElements
    describe PageElements do
      
      it "should raise ArgumentError while there is regexp without block" do
        lambda{ PageElement /some pattern with no block/ }.should raise_error(Cucumber::PathsAndPageElementsCore::PathsAndPageElements::MissingProc, "Element definitions must always have a proc")
      end
      
      it "should raise error while you try to add data for regexp more than once" do
        lambda{
          PageElement /some pattern/ do
            puts "some pattern"
          end
        
          PageElement /some pattern/ do
            puts "some pattern"
          end
        }.should raise_error("The key (?-mix:some pattern) is already present!")
      end
      
      it "should pass simple test of adding data and calling appropriate block" do
        PageElement /some test/ do
          "test OK"
        end
        match_element("some test").should == "test OK"
      end
      
      it "should return matched data from given argument" do
        PageElement /^test (\d)-(\w+)-(\d)/ do |reg_exp, matched_data|
          matched_data
        end
        match_element("test 0-foobar-1").should == ["0","foobar","1"]
      end
      
      it "should return nil where there is no matching regexp" do
        PageElement /foobar/ do
          "test OK"
        end
        match_element("test").should == nil
      end
      
    end
  end
end
