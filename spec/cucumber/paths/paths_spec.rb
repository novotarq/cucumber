require File.dirname(__FILE__) + '/../../spec_helper'
require 'cucumber/paths'

module Cucumber
  module Paths

    describe Paths do

      it "does a block of code for Regexp" do
        Path /^I am simple step$/ do "simple" end
        path_to("I am simple step").should == "simple"
      end

      it "does a block of code for String" do
        Path "I am simple step2" do "simple" end
        path_to("I am simple step2").should == "simple"
      end

      it "throws an error when block not present" do
        begin
          Path "I am simple step3"
          violated("Should raise error")
        rescue => e
          e.message.should =~ %r{Element definitions must always have a proc}m
        end
      end

      it "throws an error when input is not a String or Regexp" do
        begin
          Path Hash.new do end
          violated("Should raise error")
        rescue => e
          e.message.should == "Element patterns have to be Regexp or String, but your input was: {}"
        end
      end

      it "throws an error when input is an existing key" do
        begin
          Path "I am simple step4" do |input| "#{input}" end
          Path /^I am simple step4$/ do |input| "/" end
          violated("Should raise error")
        rescue => e
          e.message.should == "The key (?-mix:^I am simple step4$) is already present!"
        end
      end

      it "is able to fetch a value from regexp" do
        Path /try to fetch "(.*)"/ do |regex, value| value[0] end
        path_to("try to fetch \"/this value\"").should == "/this value"
      end

    end

  end
end