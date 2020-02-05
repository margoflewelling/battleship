require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'


class CellTest < Minitest::Test

  def setup
    @cell = Cell.new('B4')
    @cruiser = Ship.new("Cruiser", 3)
    @cell_2 = Cell.new('C3')
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_cell_contains_coordinate
    assert_equal 'B4', @cell.coordinate
  end

  def test_cell_starts_empty_and_ship_can_be_placed
    assert_equal nil, @cell.ship
    assert true, @cell.empty?
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
    refute @cell.empty?
  end

  def test_ship_can_be_fired_upon_and_loses_health
    @cell.place_ship(@cruiser)
    refute @cell.fired_upon?
    @cell.fire_upon
    assert_equal 2, @cruiser.health
    assert @cell.fired_upon?
  end

  def test_it_can_render
    assert_equal '.', @cell.render
    @cell.fire_upon
    assert_equal 'M', @cell.render
    @cell_2.place_ship(@cruiser)
    assert_equal '.', @cell_2.render
    assert_equal 'S', @cell_2.render(true)
  end





end
