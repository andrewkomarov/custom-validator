module Validation

  def self.included(class_reference)
    class_reference.extend ClassMethods
  end

  module ClassMethods
    def validate(name, options)
      if self.class_variables.include?(:@@rules)
        rules = self.class_variable_get(:@@rules) << {name => options}
      else
        rules = []
        rules << {name => options}
      end
      self.class_variable_set :@@rules, rules
    end
  end

  def validate!
    #puts self.class.class_variable_get(:@@rules)
    #return
    rules = self.class.class_variable_get(:@@rules)
    rules.each do |rule|
      rule.each do |attr, options|
        options.each do |option, value|
          unless send(option, attr, value)
            begin
              raise Exception.new "*#{attr}* attribute validation failed"
            rescue Exception => e
              puts e.message
            end
          end
        end
      end
    end
  end

  # All validations passed
  def valid?
    passed = true
    rules = self.class.class_variable_get(:@@rules)
    rules.each do |rule|
      rule.each do |attr, options|
        options.each do |option, value|
          unless send(option, attr, value)
            passed = false
            return passed
          end
        end
      end
    end
    passed
  end

  # Validation rule methods
  def presence(attr, value)
    attr = send(attr).to_s
    valid = value ? !attr.empty? : attr.empty?
    attr && valid
  end

  def format(attr, value)
    attr = send(attr).to_s
    attr && attr.match(value) ? true : false
  end

  def type(attr, value)
    attr = send(attr)
    attr && attr.kind_of?(value) ? true : false
  end


end