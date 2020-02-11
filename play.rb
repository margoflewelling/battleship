class PlayGame

attr_reader :board, :message, :cruiser, :submarine

def initialize(comp_board, player_board, message, comp_cruiser, comp_sub, player_cruiser, player_sub)
  @comp_board = comp_board
  @player_board = player_board
  @message = message
  @comp_cruiser = comp_cruiser
  @comp_sub = comp_sub
  @player_cruiser = player_cruiser
  @player_sub = player_sub
end

def place_the_cruiser
  @message.place_cruiser
  cruiser_placement = gets.chomp.split(' ')
  until @player_board.valid_placement?(@player_cruiser, cruiser_placement)
    p 'Those are invalid coordinates. Please try again!'
    cruiser_placement = gets.chomp.split(' ')
  end
  @player_board.place(@player_cruiser, cruiser_placement)
end

def place_the_sub
  @message.place_sub
  sub_placement = gets.chomp.split(' ')
  until @player_board.valid_placement?(@player_sub, sub_placement)
    p 'Those are invalid coordinates. Please try again!'
    sub_placement = gets.chomp.split(' ')
  end
  @player_board.place(@player_sub, sub_placement)
end

def orientation
  @orientation = ["h", "v"].sample(1)
end

def add_numbers(ship_length)
  number_choices = []
  @numbers.each_cons(ship_length) {|a| number_choices << a}
  selected_numbers = number_choices.sample(1)
  @coordinates = @placement.zip(selected_numbers)
  @coordinates = @coordinates.map {|coordinate| coordinate.join}
end

def add_letters(ship_length)
  letter_choices = []
  @letters.each_cons(ship_length) {|a| letter_choices << a}
  selected_letters = (letter_choices.sample(1))[0]
  @coordinates = selected_letters.zip(@placement)
  coordinates = @coordinates.map {|coordinate| coordinate.join}
end

def make_comp_ship(ship_length)
  @letters = ["A", "B", "C", "D"]
  @numbers = [1, 2, 3, 4]
  if orientation == "h"
    @placement = Array.new(ship_length,
    @letters.sample(1))
    add_numbers(ship_length)
  else
    @placement = Array.new(ship_length, (@numbers.sample(1))[0])
    add_letters(ship_length)
  end
    @coordinates
end


end
