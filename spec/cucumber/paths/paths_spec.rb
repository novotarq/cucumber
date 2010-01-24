require File.dirname(__FILE__) + '/../../spec_helper'
require 'cucumber/paths/path_resolver'

module Cucumber
  module Paths

    describe PathResolver do

      it "does a block of code for Regexp" do
        paths = PathResolver.new
        paths.Path /^I am simple step$/ do "simple" end
        paths.path_to("I am simple step").should == "simple"
      end

      it "does a block of code for String" do
        paths = PathResolver.new
        paths.Path "I am simple step" do "simple" end
        paths.path_to("I am simple step").should == "simple"
      end

      it "throws an error when block not present" do
        begin
          paths = PathResolver.new
          paths.Path "I am simple step"
          violated("Should raise error")
        rescue => e
          e.message.should =~ %r{Path definitions must always have a proc}m
        end
      end

      it "throws an error when input is not a String or Regexp" do
        begin
          paths = PathResolver.new
          paths.Path Hash.new do end
          violated("Should raise error")
        rescue => e
          e.message.should == "Path patterns have to be Regexp or String, but your input was: {}"
        end
      end

      it "throws an error when input is an existing key" do
        begin
          paths = PathResolver.new
          paths.Path "I am simple step" do |input| "#{input}" end
          paths.Path /^I am simple step$/ do |input| "/" end
          violated("Should raise error")
        rescue => e
          e.message.should == "The key (?-mix:^I am simple step$) is already present!"
        end
      end

    end

  end
end