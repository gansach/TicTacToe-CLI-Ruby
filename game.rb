require "pry"
class Board
    def initialize
        @array = ["1", "2", "3",
                  "4", "5", "6",
                  "7", "8", "9"]

        @current_player = "X"
        @turns = 0
        @x_markers = []
        @o_markers = []
        @winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                          [1, 4, 7], [2, 5, 8], [3, 6, 9],
                          [1, 5, 9], [3, 5, 7]]
        self.print_board
    end

    private
    def print_board
        puts "\n#{@array[0]}|#{@array[1]}|#{@array[2]}\n"\
             "-----\n"\
             "#{@array[3]}|#{@array[4]}|#{@array[5]}\n"\
             "-----\n"\
             "#{@array[6]}|#{@array[7]}|#{@array[8]}\n\n"
    end

    public
    def place_marker(current_player, position)
        @array[position - 1] = current_player

        if current_player == "X"
            @x_markers << position
        else
            @o_markers << position
        end
        self.print_board
        self.check_winner
    end

    def get_position
        print "Place marker for #{@current_player} at: "
        position = gets.chomp.to_i
        
        until position >= 1 && position <= 9
            print "Invalid input, please provide valid input: "
            position = gets.chomp.to_i 
        end

        while @array[position - 1] == "X" || @array[position - 1] == "O"
            print "Position has been marked already, provide valid input: "
            position = gets.chomp.to_i 
        end

        return position
    end

    def player_select
        if @turns != 0
            @current_player = @current_player == "X" ? "O" : "X"
        end
        @turns += 1
        return @current_player
    end

    def check_winner
        if @turns >= 5
            x_possibilities = []
            o_possibilities = []
            if @x_markers.length >= 3
                for i in 0...@x_markers.length - 2
                    x_possibilities << [@x_markers.sort[i], @x_markers.sort[i+1], @x_markers.sort[i+2]] 
                end
                x_possibilities.each do |x|
                    if @winning_lines.include? x
                        puts "X won"
                        return 0
                    end
                    if @turns == 9
                        puts "Its a Tie"
                        return 0
                    end
                end
            end
            if @o_markers.length >= 3
                for i in 0...@o_markers.length - 2
                    o_possibilities << [@o_markers.sort[i], @o_markers.sort[i+1], @o_markers.sort[i+2]] 
                end
                o_possibilities.each do |o|
                    if @winning_lines.include? o
                        puts "O won"
                        return 0
                    end
                end
            end
        end 
    end
end

b = Board.new
until b.check_winner == 0
    b.place_marker(b.player_select, b.get_position)
end