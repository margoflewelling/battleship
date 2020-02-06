require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'


class BoardTest < Minitest::Test

    def setup
      @board = Board.new
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)
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

    def test_valid_ship_placement_by_length
      assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
        assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
        assert_equal true, @board.valid_placement?(@submarine, ["A2", "A3"])
    end

    def test_consecutive_placement
      assert_equal false, @board.valid_placement?(@submarine, ["A3", "B1"])
      assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
      assert_equal true, @board.valid_placement?(@submarine, ["A2", "A3"])
      assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
      assert_equal true, @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
    end

    def test_placing_a_ship
      @board.place(@cruiser, ["A1", "A2", "A3"])
        cell_1 = @board.cells["A1"]
        cell_2 = @board.cells["A2"]
        cell_3 = @board.cells["A3"]
      assert_equal @cruiser, cell_1.ship
      assert_equal @cruiser, cell_2.ship
        assert_equal @cruiser, cell_3.ship
      assert_equal true, cell_3.ship == cell_2.ship
      end

      def test_overlapping_ships
        @board.place(@cruiser, ["A1", "A2", "A3"])
        assert_equal false, @board.valid_placement?(@submarine, ["A1", "B1"])
        assert_equal true, @board.valid_placement?(@submarine, ["B1", "C1"])
      end

      def test_render
        @board.place(@cruiser, ["A1", "A2", "A3"])
        expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
        assert_equal expected, @board.render

        true_expected = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
        assert_equal true_expected, @board.render(true)

        cell_1 = @board.cells["A1"]
        cell_1.fire_upon
        cell_8 = @board.cells["B4"]
        cell_8.fire_upon
        @board.place(@submarine, ["C1", "D1"])
        cell_9 = @board.cells["C1"]
        cell_13 = @board.cells["D1"]
        cell_9.fire_upon
        cell_13.fire_upon
        hits_expected = "  1 2 3 4 \nA H . . . \nB . . . M \nC X . . . \nD X . . . \n"
        assert_equal hits_expected, @board.render

      end


end
