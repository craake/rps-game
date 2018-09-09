# frozen_string_literal: true

module RockPaperScissors
  # Game logic
  class Game
    include Singleton
    include RockPaperScissors

    attr_reader :score

    SCORES = %i[victory defeat draw].freeze

    def initialize
      @score = []
    end

    # Decides whether the subject can beat opponent
    # Params:
    # - subject: symbol, one of the RockPaperScissors.rules
    # - opponent: symbol, one of the RockPaperScissors.rules
    def can_beat?(subject:, opponent:)
      RULES[subject][:beats].include? opponent
    end

    # Decides whether it is a draw
    def draw?(subject:, opponent:)
      subject == opponent
    end

    # Use Ruby magic to handle add_score_* methods
    # Valid choices are:
    #   - add_score_victory
    #   - add_score_defeat
    #   - add_score_draw
    # All other will be ignored
    def method_missing(name, *args, &block)
      if name.to_s.start_with?('add_score_')
        score = name.to_s.split('add_score_').last.to_sym
        if SCORES.include?(score)
          @score << score
        else
          super
        end
      else
        super
      end
    end

    # Filters out what will be handled and what won't
    def respond_to_missing?(name, include_private = false)
      name.to_s.start_with?('add_score_') || super
    end
  end
end