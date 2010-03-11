module Cucumber
  module PathsAndPageElementsCore
    
    def self.exec_block(input, type)
      exec_put.exec_block(input)
    end

    def self.Put(regexp, &proc, type)
      exec_put.Put(regexp, &proc, type)
    end

    def self.exec_put
      @paths_and_page_elements ||= PathsAndPageElements.new
    end
    
    class PathsAndPageElements
      
      class MissingProc < StandardError
        def message
          "Path definitions must always have a proc"
        end
      end
      
      def initialize
        @blocks = Hash.new
        @blocks[:path] = Hash.new
        @blocks[:page_element] = Hash.new
      end

      def Put(key, &proc, type)
        raise MissingProc if proc.nil?
        
        regexp = case(key)
        when String
          Regexp.new("^#{key}$")
        when Regexp
          key
        else
          raise "Path patterns have to be Regexp or String, but your input was: #{key.inspect}"
        end
        
        if @blocks.has_key?(regexp)
          raise "The key #{regexp} is already present!"
        end
        @blocks[type] << [regexp,proc]
      end

      def exec_block(step_name, type)
        matched_step = match_step(step_name, type)
        matched_step[2].call(matched_step[0], matched_step[1])
      end
      
      def match_step(step_name, type)
        matched_step = nil
        
        @blocks.map do |elem_type, elem_value|
          if elem_type == type
            @elem_value.map do |regexp, proc|
              if step_name =~ regexp
                matched_step = [regexp, $~.captures, proc]
                break
              end
            end  
          end
        end
        matched_step
      end
      
    end
  end
end