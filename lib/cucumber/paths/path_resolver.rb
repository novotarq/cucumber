module Cucumber
  module Paths
    
    def self.path_to(input)
      exec_path.path_to(input)
    end

    def self.Path(regexp, &proc)
      exec_path.Path(regexp, &proc)
    end

    def self.exec_path
      @paths ||= PathResolver.new
    end
    
    class PathResolver
      
      class MissingProc < StandardError
        def message
          "Path definitions must always have a proc"
        end
      end
      
      def initialize
        @blocks = Hash.new
      end

      def Path(key, &proc)
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
        @blocks[regexp] = proc
      end

      def path_to(step_name)
        matched_step = match_step(step_name)
        matched_step[2].call(matched_step[0], matched_step[1])
      end
      
      def match_step(step_name)
        matched_step = nil
        @blocks.map do |regexp, proc|
          if step_name =~ regexp
            matched_step = [regexp, $~.captures, proc]
            break
          end
        end
        matched_step
      end
      
    end
  end
end