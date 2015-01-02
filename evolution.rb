class Evolution

  def self.exec(monsters)
    pool = []
    monsters.each{|m| pool.push m}
    6.times{pool.push self.crossing(monsters)}
    pool.push self.mutant(pool.sample)

    pool.each do |mon|
      Simulation.new(mon).result(STEP)
    end
    pool.sort!{|a, b| b.score <=> a.score }

    ret_pool = []
    ret_pool.push pool[0]
    ret_pool.push [pool[1],pool[1],pool[2],pool[2],pool[3],pool[3]].sample
    ret_pool.push [
      pool[2],pool[2],pool[2],pool[2],pool[3],pool[3],pool[3],pool[4],pool[4],pool[5]
      ].sample
    while(ret_pool[1] == ret_pool[2])
      ret_pool[2] = [
      pool[1],pool[1],pool[2],pool[2],pool[3],pool[4],pool[5],pool[6]
      ].sample
    end

    return ret_pool
  end

  def self.crossing(monsters)
    array = []
    STEP.times do |i|
      array.push monsters[rand(0..2)].action[i]
    end
    return Monster.new(array)
  end

  def self.mutant(monster)
    rand(3..8).times do
      monster.action[rand(0..STEP-1)] = [:u,:d,:r,:l].sample
    end
    return monster
  end

end