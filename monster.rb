class Monster
attr_accessor :x,:y,:hp,:action

  def initialize(action)
    @x = START_X
    @y = START_Y
    @action = action
    @hp = HP
  end

  def init_action
    @action = []
    STEP.times{@action.push [:u,:d,:r,:l].sample}
  end

  def score
    (18 - distance)*3+@hp
  end

  def distance
    Math.sqrt(((@x-GOAL_X)*(@x-GOAL_X)+@y*@y).to_f)
  end

end