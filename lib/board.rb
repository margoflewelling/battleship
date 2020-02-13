class Board
  attr_reader :cells
  attr_accessor :reveal

  def initialize
    @cells = {"A1"=> Cell.new("A1"), "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"), "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"), "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"), "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"), "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"), "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"), "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"), "D4" => Cell.new("D4")}
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def valid_placement?(ship, placement)
    ship.length == placement.length && consecutive_placements(placement) && on_board_placement(placement) &&
    no_overlapping_ships?(placement)
  end

  def on_board_placement(placement)
    placement.all? do |coordinate|
      valid_coordinate?(coordinate)
    end

  end

  def consecutive_placements(placement)
    @coordinate_letters = []
    @coordinate_numbers = []
    placement.each do |coordinate|
      @coordinate_letters << coordinate[0]
      @coordinate_numbers << coordinate[1].to_i
      end
    if @coordinate_letters.uniq.size == 1 && valid_numbers
      true
    elsif @coordinate_numbers.uniq.size == 1 && valid_letters
      true
    else
      false
    end
  end

  def valid_numbers
    numbers = [1, 2, 3, 4]
    cruiser_number_choices = []
    sub_number_choices = []
    numbers.each_cons(3) {|a| cruiser_number_choices << a}
    numbers.each_cons(2) {|a| sub_number_choices << a}
    all_number_choices = cruiser_number_choices + sub_number_choices
    all_number_choices.include?(@coordinate_numbers)
  end

  def valid_letters
    letters = ['A', 'B', 'C', 'D']
    cruiser_letter_choices = []
    sub_letter_choices = []
    letters.each_cons(3) {|a| cruiser_letter_choices << a}
    letters.each_cons(2) {|a| sub_letter_choices << a}
    all_letter_choices = cruiser_letter_choices + sub_letter_choices
    all_letter_choices.include?(@coordinate_letters)
  end


  def no_overlapping_ships?(placement)
    cells_are_empty = []
    placement.each do |cell|
     cells_are_empty << @cells[cell].empty?
    end
    cells_are_empty.all?
  end


  def place(ship, placement)
    if valid_placement?(ship, placement)
      placement.each do |cell|
      @cells[cell].place_ship(ship)
      end
    end
  end


  def render(reveal = false)
    @reveal = reveal
    rendered = ""
    @cells.each do |coordinate, cell|
      rendered << @cells[coordinate].render(reveal)
      rendered << " "
    end
    board = "  1 2 3 4 \n" +
      "A #{rendered[0..7]}\n" +
      "B #{rendered[8..15]}\n" +
      "C #{rendered[16..23]}\n" +
      "D #{rendered[24..-1]}\n"
    puts board
    return board
  end

end
