class Item

  include Validation
  attr_accessor :title, :price

  validate :title, :presence => true
  validate :title, :type => String
  validate :price, :format => /^\d+(\.\d+)?$/

  def initialize(
      title, price
  )
    @title = title
    @price = price
  end

end