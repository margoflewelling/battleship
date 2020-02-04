require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require pry

class CellTest < Minitest::Test

  def test_it_exists
    cell = Cell.new('B4')
    assert_equal 'B4', cell.coordinate
  end   

end
