require_relative "piece"
require_relative "stepable"

class Knight < Piece
    include Stepable
    attr_reader :symbol
    attr_accessor :pos

    def initialize(color, board, pos) 
        super
        @symbol = " ♞ "
    end

    def move_diffs 
        [ [1,2], [1,-2], [-1,2], [-1,-2], [2, 1], [2, -1], [-2, 1], [-2, -1] ]
    end

end

class King < Piece
    include Stepable
    attr_reader :symbol
    attr_accessor :pos

    def initialize(color, board, pos) 
        super
        @symbol = " ♚ "
    end

     def move_diffs
        [ [0, -1], [0, 1], [-1, 0], [1, 0], [-1, 1], [-1, -1], [1, 1], [1, -1] ]
    end
end