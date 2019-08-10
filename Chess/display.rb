require_relative "board.rb"
require_relative "cursor"
require "colorize"

class Display
    attr_reader :cursor
    attr_accessor :selected
    def initialize(board)
        @board = board
        @cursor = Cursor.new([7,0], board)
        @selected = [] #don't forget to put back to empty array
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
                    @selected.empty? ?
                    ele.symbol.colorize(background: :green, color:ele.color) :
                    ele.symbol.colorize(background: :light_green, color:ele.color)
                elsif [row_idx, col_idx] == @selected
                    ele.symbol.colorize(background: :green, color:ele.color)
                elsif (first_back_ground_index.even?)
                    row_idx.even? ?
                    ele.symbol.colorize(background: :light_black, color:ele.color) :
                    ele.symbol.colorize(background: :cyan, color:ele.color)
                else 
                    row_idx.odd? ?
                    ele.symbol.colorize(background: :light_black, color:ele.color) :
                    ele.symbol.colorize(background: :cyan, color:ele.color)
                end
            end
            puts "#{visual_idx}" + row_to_s.join("")
            visual_idx -= 1
        end
        puts "  A  B  C  D  E  F  G  H"
        @selecting = false if @cursor.get_input.is_a?(Array)
    end

    def render
        @selecting = true
        puts "Press a movement key WASD/Arrow keys to start game and select/move pieces"
        @cursor.get_input
        show while @selecting
        @cursor.cursor_pos
    end

end