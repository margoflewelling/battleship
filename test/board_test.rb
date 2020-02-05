require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'


class BoardTest < Minitest::Test

    def setup
    @board = Board.new
    end

    def test_it_exists
      assert_instance_of Board, @board
    end

    def test_cell_attribute
      assert_equal 16, @board.cells.length
    end

    def test_if_coordinate_is_on_board
      assert_equal true, @board.valid_coordinate("A1")
      assert_equal false, @board.valid_coordinate("A5")
    end

end
