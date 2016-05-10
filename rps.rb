# Rock Paper Scissors - Ethan Steiner May, 10, 2016 (347)873-1681

class Game
  attr_accessor :player_input, :player_choice, :strategy

  # rules for game play
  RULES = {
    :rock     => {:rock => :draw, :paper => :paper, :scissors => :rock},
    :paper    => {:rock => :paper, :paper => :draw, :scissors => :scissors},
    :scissors => {:rock => :rock, :paper => :scissors, :scissors => :draw}
  }
  # keeps log of players choices for the lifecycle of one game
  @@player_choice_log = {rock: 0, paper: 0, scissors: 0}

  def initialize
    @won = 0
    @lost = 0
    @tie = 0
    @player_choice = {}
    @previous_player_choice = {}
    @strategy = select_strategy
    welcome_message
    @player_input = player_input
  end

  # handles all player input and player choice logging
  def player_input
    loop do
      puts "Type 'r', 'p' or 's'.\n"
      computer_choice = strategy_implement(strategy)
      input = gets.chomp.downcase
      if input == 'r'
        value = {rock: 1}
        player_choice.clear
        player_choice.merge!(value)
        puts "Rock\n"
        play_game(value.keys.pop, computer_choice)
        @previous_player_choice = value
        add_player_choice_to_log
      elsif input == 'p'
        value = {paper: 1}
        player_choice.clear
        player_choice.merge!(value)
        puts "Paper\n"
        play_game(value.keys.pop, computer_choice)
        add_player_choice_to_log
        @previous_player_choice = value
      elsif input == 's'
        value = {scissors: 1}
        player_choice.clear
        player_choice.merge!(value)
        puts "Scissors\n"
        play_game(value.keys.pop, computer_choice)
        add_player_choice_to_log
        @previous_player_choice = value
      elsif input == 'exit'
        exit_message
        break
      else
        puts "That is not a valid choice - please try again"
      end
    end
  end

  # game play logic and tracking win/loss/ties
  def play_game(human, computer)
    winner = RULES[human][computer]
    if winner == human
      @won+=1
      puts game_complete_message(computer) + "You win!"
    elsif winner == computer
      @lost+=1
      puts game_complete_message(computer) + "You lose."
    else
      @tie+=1
      puts game_complete_message(computer) + "It's a tie."
    end
    puts "you won #{@won} times.\nyou lost #{@lost} times.\nwe tied #{@tie} times.\n\n"
  end

  def add_player_choice_to_log
    choice = player_choice.keys.pop
    new_value = @@player_choice_log[choice]+1
    @@player_choice_log[choice] = new_value
  end

  # computer strategy picker
  def select_strategy
    strategy_picker = [1, 2, 3].sample
    return strategy_picker
  end

  # computer strategy implementer
  def strategy_implement(strategy_picker)
    if strategy_picker == 1
      computer_strategy = beat_last_move
    elsif strategy_picker == 2
      computer_strategy = beat_favorite
    else
      computer_strategy = random_computer
    end
  end

  # computer strategies
  def beat_last_move
    if @previous_player_choice == {}
      computer_choice = [:rock, :paper, :scissors].sample
    elsif @previous_player_choice.keys.pop == :rock
      computer_choice = :paper
    elsif @previous_player_choice.keys.pop == :paper
      computer_choice = :scissors
    else
      computer_choice = :rock
    end
    return computer_choice
  end

  def beat_favorite
    if @@player_choice_log.values == [0,0,0]
      computer_choice = [:rock, :paper, :scissors].sample
    else
      favorite = @@player_choice_log.max_by{|k,v| v}
      if favorite[0] == :rock
        computer_choice = :paper
      elsif favorite[0] == :paper
        computer_choice = :scissors
      else
        computer_choice = :rock
      end
    end
    return computer_choice
  end

  def random_computer
    computer_choice = [:rock, :paper, :scissors].sample
    return computer_choice
  end

  # messaging for start, play, and exit
  def welcome_message
    puts "\n"
    puts "Welcome to Rock Paper Scissors"
  end

  def game_complete_message(computer_choice)
    if computer_choice == :rock
      "I chose 'r'. "
    elsif computer_choice == :paper
      "I chose 'p'. "
    else
      "I chose 's'. "
    end
  end

  def exit_message
    if strategy == 1
      puts "\nThank you for playing against the Beat Last Move computer strategy\n"
    elsif strategy == 2
      puts "\nThank you for playing against the Beat Player Favorite computer strategy\n"
    else
      puts "\nThank you for playing against the Random computer strategy\n"
    end
  end

end

Game.new
