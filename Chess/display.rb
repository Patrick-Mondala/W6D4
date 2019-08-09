require_relative "board.rb"

class Display

    def initialize(board)
        @board = board
        # @cursor = cursor
    end

    def render
        puts "  --- --- --- --- --- --- --- ---"
        visual_idx = 8
        @board.rows.each do |row|
            puts "#{visual_idx}| " + row.map { |ele| ele.to_s }.join(" | ") + " |"
            puts "  --- --- --- --- --- --- --- ---"
            visual_idx -= 1
        end
        puts "   A   B   C   D   E   F   G   H"
        return true
    end

end