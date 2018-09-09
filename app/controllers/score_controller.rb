# frozen_string_literal: true

# Score controller
class ScoreController < ApplicationController
  include RockPaperScissors

  # Presents scores from the current session
  def index
    @scores = RockPaperScissors::Game.instance.score.reverse
  end
end
