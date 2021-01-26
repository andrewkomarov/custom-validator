require './lib/validation'
require './item'

## --------------- title
# Works fine - title validation passed
item = Item.new 'keyboard', 155.90
item.validate!

# Exception - title validation failed (empty string)
item = Item.new '', 155.90
item.validate!

# Exception - title validation failed (type is not String)
item = Item.new 9999, 155.90
item.validate!

# Two Exceptions - title validation failed (nil and type is not String)
item = Item.new nil, 155.90
item.validate!


## --------------- price
# Works fine - price validation passed
item = Item.new 'keyboard', '155.90'
item.validate!

# Exception - price validation faled (string - does not correspond to given regexp)
item = Item.new 'keyboard', 'some price'
item.validate!

# Exception - price validation faled (empty string - does not correspond to given regexp)
item = Item.new 'keyboard', ''
item.validate!


## --------------- All validations
# Passed
item = Item.new 'keyboard', 155.90
puts "All validations passed: #{item.valid?}"

# Failed
item = Item.new 'keyboard', 'some price'
puts "All validations passed: #{item.valid?}"

