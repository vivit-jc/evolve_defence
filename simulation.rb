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
    @map.each_with_index do |x,i|
      x.each_with_index do |y,j|
        case y
        when 1
          if(@monster.x == i && @monster.y == j)
            @monster.hp -= 2
          end
        when 2
          if(@monster.x >= i-1 && @monster.x <= i+1 && @monster.y >= j-1 && @monster.y <= j+1)
            @monster.hp -= 1
          end
        end
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
    @map[@monster.x][@monster.y] = 0
    @turn += 1
  end

  def finished?
    return true if(@monster.hp <= 0)
    return true if(@monster.x == 7 && @monster.y == 0)
    return false
  end

end