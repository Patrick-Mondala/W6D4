require_relative "knight_king.rb"
require_relative "rook_bishop_queen.rb"
require_relative "pawn.rb"
require_relative "null_piece.rb"

class Board
    attr_reader :sentinel, :populate_board #maybe remove later
    attr_accessor :rows
    def initialize
        @sentinel = NullPiece.instance
        @rows = Array.new(8) { Array.new(8, @sentinel) }
        populate_board
    end

    def [](pos)
        self.rows[pos.first][pos.last]
    end

    def []=(pos, value)
        self.rows[pos.first][pos.last] = value
    end

    def populate_board
        place_kings
        place_queens
        place_bishops
        place_knights
        place_rooks
        place_pawns
    end

    def place_kings
        black_king_position = [0, 4]
        self[black_king_position] = King.new(:black, self, black_king_position)
        white_king_position = [7, 4]
        self[white_king_position] = King.new(:white, self, white_king_position)
    end

    def place_queens
        black_queen_position = [0, 3]
        self[black_queen_position] = Queen.new(:black, self, black_queen_position) 
        white_queen_position =  [7, 3]
        self[white_queen_position] = Queen.new(:white, self, white_queen_position)
    end

    def place_rooks
        black_rook_positions = [[0, 0], [0, 7]]
        black_rook_positions.each { |position| self[position] = Rook.new(:black, self, position) }
        white_rook_positions = [[7, 0], [7, 7]]
        white_rook_positions.each { |position| self[position] = Rook.new(:white, self, position) }
    end

    def place_bishops
        black_bishops_positions = [[0, 2], [0, 5]]
        black_bishops_positions.each { |position| self[position] = Bishop.new(:black, self, position) }
        white_bishops_positions = [[7, 2], [7, 5]]
        white_bishops_positions.each { |position| self[position] = Bishop.new(:white, self, position) }
    end

    def place_knights
        black_knights_positions = [[0, 1], [0, 6]]
        black_knights_positions.each { |position| self[position] = Knight.new(:black, self, position) }
        white_knights_positions = [[7, 1], [7, 6]]
        white_knights_positions.each { |position| self[position] = Knight.new(:white, self, position) }
    end

    def place_pawns
        (0..7).each {|col| self.rows[1][col] = Pawn.new(:black, self, [1, col])}
        (0..7).each {|col| self.rows[6][col] = Pawn.new(:white, self, [6, col])}
    end

    def move_piece(start_pos, end_pos)
        starting_piece = self[start_pos]
        raise "starting position is null try again" if starting_piece == @sentinel
        raise "moves does not include end_pos #{starting_piece.moves}" unless starting_piece.moves.include?(end_pos)
        #later only raises if same color
        self[end_pos] = starting_piece
        self[start_pos] = @sentinel
        starting_piece.pos = end_pos
    end
end