require './monster'
require './simulation'
require './evolution'
require './map'
require 'pp'

STEP = 40
HP = 20
START_X = 7
START_Y = 14
GOAL_X = 7

scores = []
10.times do
  time = Time.now
  monsters = []
  3.times{ monsters.push Monster.new([])}
  monsters.each{|m| m.init_action}

  100.times do
    monsters = Evolution.exec(monsters)
    print "."
  end

print "\n"
p [monsters[0].x,monsters[0].y,monsters[0].hp]
p monsters[0].score
scores.push monsters[0].score

end

pp scores
