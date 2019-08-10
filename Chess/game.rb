require_relative "board"
require_relative "display"

class Game

    def initialize(board)
        @board = board
        @display = Display.new(@board)
        @current_player = :white
        run
    end

    def swap_turn!
        oppenent_color = (@current_player == :white) ? :black : :white
        @current_player = oppenent_color
    end

    def play
        begin
        @display.selected = cursor_select_position
        @board.move_piece(@current_player, @display.selected, cursor_select_position)
        rescue => e
            @display.selected = []
            puts "#{e}"
            sleep(2)
            retry
        end
        @display.selected = []
        @display.show
        swap_turn!
    end

    def cursor_select_position
        @display.render
    end

    def run 
        play until @board.checkmate?(@current_player)
        puts "#{@board.winner} wins!"
        puts "play again? enter 'y' for new game"
        run if gets.chomp.downcase == "y"
    end
end

board = Board.new
game = Game.new(board)