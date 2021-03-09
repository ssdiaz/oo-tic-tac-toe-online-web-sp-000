class TicTacToe

  def initialize    #  assigns an instance variable @board to an array with 9 blank spaces " "
    @board = [" "," "," "," "," "," "," "," "," "]
  end

  # defines a constant WIN_COMBINATIONS with arrays for each win combination
  WIN_COMBINATIONS = [
    [0,1,2],  # across 1
    [3,4,5],  # across 2
    [6,7,8],  # across 3
    [0,3,6],  # down 1
    [1,4,7],  # down 2
    [2,5,8],  # down 3
    [0,4,8],  # diagonal l to r
    [2,4,6]   # diagonal r to l
  ]

# Helper Methods

  def display_board   # prints arbitrary arrangements of the board
    puts  " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts  "-----------"
    puts  " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts  "-----------"
    puts  " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    #   Accepts the user's input (a string) as an argument
    #   Converts the user's input (a string) into an integer
    #   Converts the user's input from the user-friendly format (on a 1-9 scale) to the array-friendly format (where the first index starts at 0)
    user_input.to_i - 1  #converts string into int. and subs 1 for array index
  end

  def move(index_chosen, player_token = "X")    # allows "X" player in the top left and "O" in the middle
    @board[index_chosen] = player_token
  end

  def position_taken?(index_chosen)              # returns true/false based on whether the position on the board is already occupied
    @board[index_chosen] == " " ? false : true    # free position should return false, as in "false/no it's not taken"
  end

  def valid_move?(index_chosen)
    #   Returns true/false based on whether the position is already occupied, true if move is valid
    #   Checks that the attempted move is within the bounds of the game board
    position_taken?(index_chosen) == false && index_chosen.between?(0,8)
  end

  def turn_count     # counts occupied positions
    counter = 0
    @board.each do |move|
      if move != " "
        counter += 1
      end
    end
    counter
  end

  def current_player
    # returns the correct player, X, for the third move
    # returns the correct player, O, for the fourth move
   turn_count.even? ? "X" : "O" # inverse, if even numbers on board means it's odd's turn (X)
  end

  def turn
    # receives user input via the gets method
    # calls #input_to_index, #valid_move?, and #current_player
    # makes valid moves and displays the board
    # asks for input again after a failed validation
    puts "Please enter a number 1-9:"
    user_input = gets.strip
    index_chosen = input_to_index(user_input)
    player_token = current_player

    if valid_move?(index_chosen)
      move(index_chosen, player_token)
      display_board
    else
      turn
    end

  end

  def won?
    WIN_COMBINATIONS.any? do |win_combo|
      if position_taken?(win_combo[0]) && @board[win_combo[0]] == @board[win_combo[1]] && @board[win_combo[1]] == @board[win_combo[2]]
        return  win_combo
      end
    end
  end

  def full?
    @board.all? {|index| index == "X" || index == "O"}
  end

  def draw?
    full? && won? == false
  end

  def over?
    won? || draw?
  end

  def winner
    if won?
      @board[won?[0]]
    end
  end

  def play
    turn until over?
    if won?
      puts "Congratulations #{winner}!"
    else draw?
      puts "Cat's Game!"
    end
  end



end
