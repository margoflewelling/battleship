class PlayGame

  attr_reader :board, :message, :cruiser, :submarine


  def setup
    @comp_board = Board.new
    @player_board = Board.new
    @comp_cruiser = Ship.new('Cruiser', 3)
    @player_cruiser = Ship.new('Cruiser', 3)
    @comp_sub = Ship.new('Submarine', 2)
    @player_sub = Ship.new('Submarine', 2)
    @message = Messages.new(@player_board, @comp_board)
  end

  def initialize(comp_board, player_board, message, comp_cruiser, comp_sub, player_cruiser, player_sub)
    @comp_board = comp_board
    @player_board = player_board
    @message = message
    @comp_cruiser = comp_cruiser
    @comp_sub = comp_sub
    @player_cruiser = player_cruiser
    @player_sub = player_sub
    @all_player_guesses = []
    @all_computer_guesses = []
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

  def place_comp_ships
    @comp_board.place(@comp_cruiser, make_comp_ship(3))
    @comp_sub_cordinates = make_comp_ship(2)
    until @comp_board.valid_placement?(@comp_sub, @comp_sub_cordinates)
      @comp_sub_cordinates = make_comp_ship(2)
    end
    @comp_board.place(@comp_sub, @comp_sub_cordinates)
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
    @coordinates = @coordinates.map {|coordinate| coordinate.join}
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

  def display_boards
    p "*********COMPUTER BOARD*********"
    @comp_board.render
    p "**********PLAYER BOARD**********"
    @player_board.render(true)
  end

  def player_guess
    display_boards
    p "Enter the coordinate for your shot:"
    @guess = gets.chomp
    if !@comp_board.cells.include?(@guess) || @all_player_guesses.include?(@guess)
      p "Please enter a valid coordinate"
      @guess = gets.chomp
    end
    @all_player_guesses << @guess
    @comp_board.cells["#{@guess}"].fire_upon
    return_player_shot_result
  end

  def computer_guess
    @comp_guess = @comp_board.cells.keys.sample(1)
    if @all_computer_guesses.include?(@comp_guess)
      @comp_guess = @comp_board.cells.keys.sample(1)
    end
    @player_board.cells[@comp_guess[0]].fire_upon
    @all_computer_guesses << @comp_guess
      return_comp_shot_result
  end

  def return_player_shot_result
    if @comp_board.cells["#{@guess}"].render == "M"
      puts "Your shot on #{@guess} was a miss"
    elsif @comp_board.cells["#{@guess}"].render == "H"
        puts "Your shot on #{@guess} was a hit"
    elsif @comp_board.cells["#{@guess}"].render == "X"
       puts "Your shot on #{@guess} sunk a ship"
    end
  end

  def return_comp_shot_result
    if @player_board.cells[@comp_guess[0]].render == "M"
      puts "My shot on #{@comp_guess[0]} was a miss"
    elsif @player_board.cells[@comp_guess[0]].render == "H"
       puts "My shot on #{@comp_guess[0]} was a hit"
    elsif @player_board.cells[@comp_guess[0]].render == "X"
      puts "My shot on #{@comp_guess[0]} sunk a ship"
    end

  end

  def take_turn
    player_guess
    computer_guess
  end

  def comp_wins
    @player_cruiser.sunk? && @player_sub.sunk?
  end

  def player_wins
    @comp_sub.sunk? && @comp_cruiser.sunk?
  end

  def play_game
    place_comp_ships
    place_the_cruiser
    place_the_sub
    display_boards
    until comp_wins || player_wins
       take_turn
    end
    if comp_wins
      p "I won!"
    elsif player_wins
      p "You won!"
    end
  end


end
