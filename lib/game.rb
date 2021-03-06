class Game
  attr_accessor :board, :player_1, :player_2

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

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    self.player_1 = player_1
    self.player_2 = player_2
    self.board = board
  end
  
  def current_player
    current_turn = self.board.turn_count
    
    if current_turn.odd?
      player_1.token
    else
      player_2.token
    end
  end
  
  def won?
    
  end
  
  def draw?
    
  end
  
  def over?
    
  end
  
  def winner
    
  end

  def current_player
    current_turn = self.board.turn_count.odd? ? player_2 : player_1
  end

  def won?
    WIN_COMBINATIONS.each do |combination|
      if combination.all? {|index| self.board.cells[index] == "X"} || combination.all? {|index| self.board.cells[index] == "O"}
        return combination
      end
    end
    false
  end

  def full?
    self.board.cells.all? {|token| token == "X" || token == "O"}
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || full? || won?
  end

  def winner
    answer = nil
    WIN_COMBINATIONS.each do |combination|
      if combination.all? {|index| self.board.cells[index] == "X"}
        answer = "X"
      elsif combination.all? {|index| self.board.cells[index] == "O"}
        answer = "O"
      end
    end
    answer
  end

  def turn
    current_move = current_player.move(self.board)
    until self.board.valid_move?(current_move) do
      puts "invalid"
      current_move = current_player.move(self.board)
    end
    self.board.cells[current_move.to_i - 1] = current_player.token
  end

  def play
    until over? do
      turn
    end

    if draw?
      puts "Cat's Game!"
    else
      puts "Congratulations #{winner}!"
    end
  end

end
