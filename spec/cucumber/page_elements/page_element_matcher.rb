require File.dirname(__FILE__) + '/../../spec_helper'
require 'cucumber/page_elements/page_element_matcher'

module Cucumber
  module PageElements
    describe PageElementMatcher do
      
      before do
        @pem = PageElementMatcher.new
      end
      
      it "should raise ArgumentError while there is regexp without block" do
        lambda{ @pem.add_page_element /some pattern with no block/ }.should raise_error(ArgumentError, "Block must be given.")
      end
      
      it "should raise PageElementError while you try to add data for regexp more then once" do
        lambda{
          @pem.add_page_element /some pattern/ do
            puts "some pattern"
          end
        
          @pem.add_page_element /some pattern/ do
            puts "some pattern"
          end
        }.should raise_error(PageElementError)
      end
      
      it "should pass simple test of adding data and calling appropriate block" do
        @pem.add_page_element /test/ do
          "test OK"
        end
        @pem.match_element("test").should == "test OK"
      end
      
      it "should return matched data from given argument" do
        @pem.add_page_element /^test (\d)-(\w+)-(\d)/ do |reg_exp, matched_data|
          matched_data
        end
        @pem.match_element("test 0-foobar-1").should == ["0","foobar","1"]
      end
      
      it "should return nil where there is no matching regexp" do
        @pem.add_page_element /foobar/ do
          "test OK"
        end
        @pem.match_element("test").should == nil
      end
      
    end
  end
end