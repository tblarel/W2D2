require_relative "board.rb"
require_relative "cursor.rb"
require "colorize"

class Display
    attr_reader :board, :cursor

    def initialize
        @board = Board.new
        @cursor = Cursor.new([1,0], board)
    end

    def render
        self.board.grid.each_with_index do |row,idx1|
            row.each_with_index do |piece,idx2|
                piece_name = piece.to_s
                if [idx1,idx2] == @cursor.cursor_pos
                    to_print = piece_name
                    print to_print.colorize(:background => :green )
                else
                    to_print = piece_name
                    if idx1.even? #even row, make odd columns black
                        if idx2.odd?
                            print to_print.colorize(:background => :light_blue)
                        else
                            print to_print.colorize(:background => :light_magenta)
                        end
                    else 
                        if idx2.even?
                            print to_print.colorize(:background => :light_blue)
                        else
                            print to_print.colorize(:background => :light_magenta)
                        end
                    end
                    #print piece_name[0]
                end  
            end
            puts(" ")
        end
    end
end

display  = Display.new

while true
    puts " "
    puts " "

    display.render
    display.cursor.get_input
end

