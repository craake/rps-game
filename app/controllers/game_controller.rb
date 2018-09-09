# frozen_string_literal: true

# Main controller of the game

# Offers two game modes:
#   1. Play a game (Player vs Bot)
#   2. Watch a game (Bot vs Bot)
class GameController < ApplicationController
  include RockPaperScissors

  def index; end

  def play; end

  def result
    @title = 'Player vs Bot'
    @again_link = play_path
    @p1 = validate_params(params)
    @p2 = random_rule

    if game.draw?(subject: @p1, opponent: @p2)
      game.add_score_draw
      return @result = 'Draw'
    end

    @result =
      if game.can_beat?(subject: @p1, opponent: @p2)
        game.add_score_victory
        'You won'
      else
        game.add_score_defeat
        'Bot won'
      end
  end

  def watch
    @title = 'Bot 1 vs Bot 2'
    @again_link = watch_path
    @p1 = random_rule
    @p2 = random_rule

    if game.draw?(subject: @p1, opponent: @p2)
      @result = 'Draw'
      return render 'result'
    end

    @result =
      if game.can_beat?(subject: @p1, opponent: @p2)
        'Bot 1 won'
      else
        'Bot 2 won'
      end
    render 'result'
  end

  private

  # Memorized variable
  def game
    @_game ||= RockPaperScissors::Game.instance
  end

  # Validates request data against registered shapes
  def validate_params(params)
    return params[:shape].to_sym if valid_rule? params[:shape].to_sym
    raise RockPaperScissors::Errors::CheatingError.new(shape: params[:shape])
  end
end
