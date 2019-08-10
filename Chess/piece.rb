require "colorize"
require "deep_clone"

class Piece
    attr_accessor :pos
    attr_reader :board, :color, :symbol

    def initialize(color, board, pos) 
        @color = color
        @board = board
        @pos = pos
    end
    
    def valid_moves
        theoretic_board_states = []
        self.moves.each do |move|
            theoretic_board = DeepClone.clone(@board)
            theoretic_board.move_piece!(color, @pos, move)
            theoretic_board_states << [theoretic_board, move] unless theoretic_board.in_check?(color)
        end
        theoretic_board_states.empty? ? [] : theoretic_board_states.map {|move| move.last}
    end

    def to_s
        self.symbol.to_s.colorize(self.color)
    end

end