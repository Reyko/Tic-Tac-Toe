require 'pry'

class Board
  def initialize
    @board = [
      %w(. . .),
      %w(. . .),
      %w(. . .)
    ]
  end

  def getBoard
    @board
  end

  def mark(x, y, marker)
    if @board[x][y] == "." && @board[x][y] != marker
      @board[x][y] = marker
      mark = true
    else
      mark = false
    end
    mark
  end

  def each_winning_move
    @board.each do |row|
      yield row
    end
    @board.transpose.each do |col|
      yield col
    end
    yield [@board[0][0], @board[1][1], @board[2][2]]
    yield [@board[0][2], @board[1][1], @board[2][0]]
  end

  def to_s
    board = ""
    @board.each do |x|
      board += x.join(" ")
        board += "\n"
    end
    board
  end
end

class Game
  def initialize
    @board = Board.new
    @players = [Nought, Cross]
    @turn = @players.sample
  end

  def play
  # While the game is still going on, do the following:
    puts "Your game begins!"
    # x = 0
    # y = 0
    for i in 1..9
      # 1. Show the board to the user
      puts @board
      # 2. Prompt for an co-ordinate on the Board that we want to target
      x = 0
      y = 0
      marked = user_choice do |coordinates|
      # 3. Mark the board on the given square. If the input is invalid or already
      # taken, go back to 1.
        x = coordinates[0].to_i
        y = coordinates[1].to_i 
        @board.mark(x,y,@turn.marker)
      end

      if !marked
        redo
      end
      # 4. If we've got a winner, show the board and show a congratulations method.
      if winner
        puts @board
        puts "#{winner} won!"
        break
      end
      # 5. Otherwise call next_turn and repeat.
      next_turn
      # 6. How to detect a draw?
      if i == 9
        puts @board
        puts "Draw!"
      end
    end   
  end
 
  def next_turn
    if @turn == @players[0]
      @turn = @players[1]
    elsif @turn == @players[1]
      @turn = @players[0]
    end
  end


  def winner
    # Check each of the winning moves on the board, rows, cols and diagonals
    # to see if a Player has filled a row of three consequtive squares  
    @board.each_winning_move do |move|
      if move[0] == @turn.marker && move[1] == @turn.marker && move[2] == @turn.marker
        return @turn
      end 
    end
  end

  def user_choice 
    puts "Please select which tile you want to target as x,y values"
    input = gets.chomp.split(",")

    if input.any?
      yield input
    end
  end
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
