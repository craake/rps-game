# frozen_string_literal: true

# Rules for the game
module RockPaperScissors
  # To introduce new shape with rules, do this:
  # 1. Add new hash to the returning object, following the convention
  #    _shape-name_: { beats: [_other-shapes-beatable-by-this-one_]}
  # 2. (Optional) Add an image named _shape-name_.png to assets/images
  #    By not providing dedicated image, the default one will be used
  RULES = {
    rock: { beats: [:scissors] },
    paper: { beats: [:rock] },
    scissors: { beats: [:paper] }
  }.freeze

  # Check if rule exist
  # Params:
  # - rule: symbol, one of the RockPaperScissors.RULES keys
  def valid_rule?(rule)
    RULES.key?(rule.to_sym)
  end

  # Returns the random rule
  def random_rule
    RULES.keys.sample
  end
end