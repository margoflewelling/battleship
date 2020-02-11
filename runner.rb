require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/messages'
require './play'



@comp_board = Board.new
@player_board = Board.new
@comp_cruiser = Ship.new('Cruiser', 3)
@player_cruiser = Ship.new('Cruiser', 3)
@comp_sub = Ship.new('Submarine', 2)
@player_sub = Ship.new('Submarine', 2)
@message = Messages.new(@player_board, @comp_board)
@game = PlayGame.new(@comp_board, @player_board, @message, @comp_cruiser, @comp_sub, @player_cruiser, @player_sub)


@message.welcome

response = gets.chomp.upcase
if response == 'P'
  @game.play_game
else 'Ok. Bye!'
end
