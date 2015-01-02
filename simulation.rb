class Simulation

  def initialize(monster)
    @turn = 0
    @monster = monster
    @map = Map.new.map
  end

  def result(num)
    num.times{step}
    return @monster
  end

  def step
    return if(finished?)
    [@monster.x-1,@monster.x,@monster.x+1].each do |x|
      [@monster.y-1,@monster.y,@monster.y+1].each do |y|
        next if(x > 14 || x < 0 || y > 14 || y < 0 )
        @monster.hp -= 1 if(@map[x][y] == 1)
      end
    end
    return if(@monster.hp <= 0)
    case @monster.action[@turn]
    when :u
      @monster.y -= 1
    when :d
      @monster.y += 1
    when :r
      @monster.x += 1
    when :l
      @monster.x -= 1
    end
    @monster.x = 0 if(@monster.x < 0)
    @monster.x = 14 if(@monster.x > 14)
    @monster.y = 0 if(@monster.y < 0)
    @monster.y = 14 if(@monster.y > 14)
    @monster.hp -= 2 if(@map[@monster.x][@monster.y] == 2)
    @map[@monster.x][@monster.y] = 0
    @turn += 1
  end

  def finished?
    return true if(@monster.hp <= 0)
    return true if(@monster.x == 7 && @monster.y == 0)
    return false
  end

end