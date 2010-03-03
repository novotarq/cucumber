module Cucumber
  module PageElements
    
    def self.PageElement(reg_exp, &block)
      pem.add_page_element(reg_exp, &block);
    end
    
    def self.match_element(str)
      pem.match_element str        
    end
    
    def self.pem
      @pem ||= PageElementMatcher.new
    end
    
    class PageElementMatcher
      def initialize
        @reg_exp_block = {}
      end
      
      def add_page_element(reg_exp, &block)
        raise ArgumentError.new "Block must be given." if block.nil?
        
        if @reg_exp_block.has_key?(reg_exp) 
          raise PageElementError.new reg_exp          
        else
          @reg_exp_block[reg_exp] = block
        end
      end
      
      def match_element(str)
        result = get_regexp(str)
        result[2].call(result[0], result[1]) unless result.nil?
      end
      
      def get_regexp(str)
        result = nil
        @reg_exp_block.each do |reg_exp, block|  
          match_data = str.match reg_exp
          unless match_data.nil?
            result = [reg_exp, match_data.captures, block]
            break
          end
        end
        result
      end
      
    end
    
    class PageElementError < StandardError
      def initialize(reg_exp)
        super
        @reg_exp = reg_exp
      end
      
      def message
        "Given regexp = #{@reg_exp} is already present."
      end
    end
    
  end
end
