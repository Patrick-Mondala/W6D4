require_relative "board.rb"
require_relative "cursor"
require "colorize"

class Display

    def initialize(board)
        @board = board
        @cursor = Cursor.new([7,0], board)
    end

    def show
        system "clear"
        visual_idx = 8
        first_back_ground_index = 1
        second_back_ground_index = 2
        @board.rows.each_with_index do |row, row_idx|
            row_to_s = row.map.with_index do |ele, col_idx|
                first_back_ground_index += 1
                if [row_idx, col_idx] == @cursor.cursor_pos
                    ele.symbol.colorize(background: :green, color:ele.color)
                elsif (first_back_ground_index.even?)
                    row_idx.even? ?
                    ele.symbol.colorize(background: :blue, color:ele.color) :
                    ele.symbol.colorize(background: :light_red, color:ele.color)
                else 
                    row_idx.odd? ?
                    ele.symbol.colorize(background: :blue, color:ele.color) :
                    ele.symbol.colorize(background: :light_red, color:ele.color)
                end
            end
            puts "#{visual_idx}" + row_to_s.join("")
            visual_idx -= 1
        end
        puts "  A  B  C  D  E  F  G  H"
        @testing = false if @cursor.get_input.is_a?(Array)
    end

    def render
        @testing = true
        @cursor.get_input
        show while @testing
        @cursor.cursor_pos
    end

end