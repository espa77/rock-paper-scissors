# Rock Paper Scissors - Ethan Steiner
require 'pry'
class Game
  attr_accessor :player_input, :player_choice
  RULES = {
    :rock     => {:rock => :draw, :paper => :paper, :scissors => :rock},
    :paper    => {:rock => :paper, :paper => :draw, :scissors => :scissors},
    :scissors => {:rock => :rock, :paper => :scissors, :scissors => :draw}
  }

  def initialize
    @won = 0
    @lost = 0
    @tie = 0
    @player_choice_log = {rock: 0, paper: 0, scissors: 0 }
    @player_choice = {}
    @computer_choice = {}
    strategy = select_strategy
    welcome_message
    @player_input = player_input
  end

  def player_input
    loop do
      puts "Type 'r', 'p' or 's'.\n>"
      input = gets.chomp.downcase
      if input == 'r'
        value = {rock: 1}
        player_choice.merge!(value)
        puts "Rock"
        puts "I chose 'r'. We tied"
        play_game(player_choice.keys.pop, :rock)
        add_player_choice_to_log

      elsif input == 'p'
        value = {paper: 1}
        player_choice.merge!(value)
        puts "Paper"
        puts "I chose 's'. You lose"
        play_game(player_choice.keys.pop, :scissors)
        add_player_choice_to_log

      elsif input == 's'
        value = {scissors: 1}
        player_choice.merge!(value)
        puts "Scissors"
        puts "I chose 'p'. You win"
        play_game(player_choice.keys.pop, :paper)
        add_player_choice_to_log

      elsif input == 'exit'
        break
      else
        puts "That is not a valid choice - please try again"
      end
    end
  end

  def play_game(human, computer)
    winner = RULES[human][computer]
    if winner == human
      @won+=1
    elsif winner == computer
      @lost+=1
    else
      @tie+=1
    end
    puts "you won #{@won} times.\nyou lost #{@lost} times.\nwe tied #{@tie} times."
  end

  def add_player_choice_to_log
    choice = player_choice.keys.pop
    new_value = @player_choice_log[choice]+1
    @player_choice_log[choice] = new_value
  end

  def welcome_message
    puts "\n"
    puts "Welcome to Rock Paper Scissors"
  end

  def select_strategy
    strategy_choices = [:beat_last_move, :beat_favorite, :random_computer].sample
    return strategy_choices
  end

  def beat_last_move(previous_player_choice)
    if previous_player_choice == :rock
      computer_choice = :paper
    elsif previous_player_choice == :paper
      computer_choice = :scissors
    else
      computer_choice = :rock
    end
    return computer_choice
  end

  def player_favorite
    favorite = player_choice_log.max_by{|k,v| v}
  end

  def beat_favorite(player_favorite)
    if player_favorite[0] == :rock
      computer_choice = :paper
    elsif player_favorite[0] == :paper
      computer_choice = :scissors
    else
      computer_choice = :rock
    end
    return computer_choice
  end

  def random_computer
    computer_choice = [:rock, :paper, :scissors].sample
    return computer_choice
  end

end

Game.new
