require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/messages'
require './play'


@game = PlayGame.new(@comp_board, @player_board, @message, @comp_cruiser, @comp_sub, @player_cruiser, @player_sub)

@game.setup
@game.message.welcome
response = gets.chomp.upcase
if response == 'P'
  @game.play_game
  @game.message.play_again
  response = gets.chomp.upcase
  until response == 'N'
    @game = PlayGame.new(@comp_board, @player_board, @message, @comp_cruiser, @comp_sub, @player_cruiser, @player_sub)
    @game.setup
    @game.play_game
    @game.message.play_again
    response = gets.chomp.upcase
  end
  p 'Ok. Good Playing!'
else
  p 'Ok. Bye!'
end
