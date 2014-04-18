require 'pry'

class Board
	def initialize
		@board = [
			%w(. . .),
			%w(. . .),
			%w(. . .)
		]
	end

  # TODO - Add code so that the array at co-ordinate x, y is set to the value
  # of marker, unless it has already been set.
  #
	def mark(x, y, marker)
		#binding.pry
		@board[x.to_i][y.to_i] = marker
	end

	# TODO - Have the board return each of the possible winning combinations.
	#
	def each_winning_move



		
	end

	# TODO - Add code to return the board as a String, so that it appears
	# in a 3 x 3 grid
	def to_s
		board = ""
		@board.each do |x|
			board += x.join(" ")
			 	board += "\n"
		end
		#binding.pry
		board
	end
end

class Game
	def initialize
		@board = Board.new
		@players = [Nought, Cross]
		@turn = @players.sample
	end

	# TODO - The main game loop goes in here.
	#
	def play
		
		# While the game is still going on, do the following:
			# 1. Show the board to the user
			# 2. Prompt for an co-ordinate on the Board that we want to target
			# 3. Mark the board on the given square. If the input is invalid or already
			# taken, go back to 1.
			# 4. If we've got a winner, show the board and show a congratulations method.
			# 5. Otherwise call next_turn and repeat.
			# 6. How to detect a draw?
		puts "Your game begins!"
		draw
		user_choice
		end
	end

  # TODO - Return the next player's turn. I.e. not @turn but the other one.
  #
	def next_turn
	end

	# TODO - Return the winning Class if they have won, otherwise return nil.
	#
	def winner
		# Check each of the winning moves on the board, rows, cols and diagonals
		# to see if a Player has filled a row of three consequtive squares
	end

	def user_choice 
		while true
			while true
				x=""
				y=""
				puts "Please select which tile you want to target as x,y values"
				# puts "Please select which tile you want to target in x"
				# x = gets.chomp
				input = gets.chomp.split(",")
				x=input[0]
				y=input[1]
				if x==nil||y==nil
					x,y=3
				else
					x.to_i
					y.to_i
				end
				if x.to_i<3 && y.to_i<3
					@board.mark(x,y,@turn.marker)
					draw
				    break
				else
					draw
				end	
			end		
			#binding.pry	 
	     end
	end


def draw
	puts @board.to_s	
end


class Player
	def self.filled?(row)
		row == [self.marker] * 3
	end
end

class Nought < Player
	def self.marker
		'o'
	end
end

class Cross < Player
	def self.marker
		'x'
	end
end

Game.new.play