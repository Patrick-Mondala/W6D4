require_relative "board.rb"
require_relative "cursor"
require "colorize"

class Display

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def show
        system "clear"
        puts "  --- --- --- --- --- --- --- ---"
        visual_idx = 8
        @board.rows.each_with_index do |row, row_idx|
            puts "#{visual_idx}| " + row.map.with_index { |ele, col_idx| [row_idx, col_idx] == @cursor.cursor_pos ? 
            ele.symbol.colorize(background: :blue, color:ele.color) : ele.to_s }
            .join(" | ") + " |"
            puts "  --- --- --- --- --- --- --- ---"
            visual_idx -= 1
        end
        puts "   A   B   C   D   E   F   G   H"
        @cursor.get_input
    end

    def render
        testing = true
        @cursor.get_input
        show #while testing
    end

end