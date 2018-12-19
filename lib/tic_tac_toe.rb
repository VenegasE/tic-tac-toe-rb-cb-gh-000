WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  if board[index] == " "
    false
  else
    true
  end
end

def valid_move?(board, index)
  if index.between(0,8) && !position_taken(board,index)
    true
  else
    false
  end
end

def turn(board, player)
  puts "Please choose 1-9"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board, player)
  end
end

def turn_count(board)
  turn = 0
  board.each do |position|
    if position == "X" || position == "O"
      turn += 1
    end
  end
  turn
end

def current_player(turn_count)
  if turn_count.even?
    "X"
  elsif turn_count.odd?
    "O"
  else
    nil
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]

    if (board[win_index_1] == board[win_index_2] && board[win_index_2] == board[win_index_3]) && board[win_index_1] != " "
      return combo
    end
  end
  nil
end

def full?(board)
  board.none? {|position| position == " "}
end

def draw?(board)
  if won?(board) || !full?(board)
    false
  else
    true
  end
end

def over?(board)
  if full?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  winner = won?(board)
  if winner != nil
    winner_index = winner[0]
    return board[winner_index]
  end
  nil
end

def play(board)
  player = current_player(board)
  turn(board, player)
  if over?(board)
    winner = winner(board)
    puts "Congratulations #{winner}! You have won!"
  else
    play(board)
  end
end
