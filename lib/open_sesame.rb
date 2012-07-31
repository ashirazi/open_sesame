require "open_sesame/version"

module OpenSesame
  def self.included(base)
    base.class_eval do

      @permission_checks = {}
      class << self; attr_accessor :permission_checks; end

      def self.permission(*methods, &block)
        methods.each do |i_method|

          # Store permission checking block
          self.permission_checks[i_method.to_sym] = block if block

          # Original #method becomes #method_unpermissioned
          alias_method "#{i_method}_unpermissioned", i_method

          # Create #can_method? for use by views, etc
          class_eval <<-CAN_METHOD
            def can_#{i_method}?
              block = self.class.permission_checks[:#{i_method}]
              unless block
                current_user.has_perm? "#{self}.#{i_method}"
              else
                instance_eval &block
              end
            end
          CAN_METHOD

          # Redefine method to do permission check
          class_eval <<-ADD_PERMISSION_CHECKING
            def #{i_method}(*args, &block)
              if can_#{i_method}?
                #{i_method}_unpermissioned(*args) { block.call }
              else
                raise StandardError.new "Not permitted to #{i_method} on #{self}"
              end
            end
          ADD_PERMISSION_CHECKING
        end

      end
    end
  end
end
