# encoding: utf-8

# -*- coding: utf-8 -*-

#$:.unshift File.dirname(__FILE__)
$LOAD_PATH << File.dirname(File.expand_path(__FILE__))

require 'dxruby'
require 'pp'
require 'date'

require 'game'
require 'view'
require 'controller'


STEP = 40
HP = 20
START_X = 7
START_Y = 14
GOAL_X = 7

RED = [255,0,0]
YELLOW = [255,255,0]
GRAY = [90,90,90]
WHITE = [255,255,255]
FRAME = 15
MAIN_X = 10
MAIN_Y = 10
MENU_X = 420
CLOCK_X = MENU_X
CLOCK_Y = MAIN_Y
STATUS_X = MENU_X
STATUS_Y = CLOCK_Y+20
MENU_Y = Array.new(7) {|i| STATUS_Y+50+i*32 }
MENU_HEIGHT = 30
ICON_X = MAIN_X
ICON_Y = 320
TEXTBOX_X = ICON_X+35
TEXTBOX_Y = ICON_Y
TITLEMENU_X = 200
TITLEMENU_Y = [360,392,424]
TITLEMENU_TEXT = ["NEW GAME","LOAD","EXIT"]
MENU_TEXT = ["建設","会議","研究","ヘルプ","セーブ","ロード","終了"]
MAIN = Image.new(400,300).box(0,0,400,300,WHITE)
MENU = [Image.new(100,MENU_HEIGHT).box(0,0,100,MENU_HEIGHT,WHITE)]*7
ICON = Image.new(100,100).box(0,0,100,100,WHITE)
TEXTBOX = Image.new(570,100).box(0,0,570,100,WHITE)

SOK = Sound.new("ok.wav")
SMENU = Sound.new("menu.wav")


Font12 = Font.new(12)
Font16 = Font.new(16)
Font20 = Font.new(20)
Font32 = Font.new(32)
Font60 = Font.new(60)
Font120 = Font.new(120)

Window.height = 480
Window.width = 640

game = Game.new
controller = Controller.new(game)
view = View.new(game,controller)

Window.loop do

  controller.input
  view.draw

=begin
  game.clock if(game.state == :game)
  if(game.state == :next)
    game = Game.new
    controller = Controller.new(game)
    view = View.new(game,controller)
  end
=end

end

=begin

30.times do |j|
  distances = []
  time = Time.now
  monsters = []
  3.times{ monsters.push Monster.new([])}
  monsters.each{|m| m.init_action}

    monsters.each do |m|
      m.action.each do |a|
  #      print a.to_s
      end
  #    print "\n"
    end
  #    print "\n"


  100.times do
    monsters = Evolution.exec(monsters)
    distances.push monsters[0].distance
    #p [monsters[0].x,monsters[0].y,monsters[0].hp,monsters[0].score]
    monsters.each do |m|
      m.action.each do |a|
  #      print a.to_s
      end
  #    print "\n"
    end
  #  print "\n"
  end
  distances.push monsters[0].distance
  p j,Time.now-time

  open("./scores#{j}.dat","w") do |file|
    distances.each_with_index do |s,i|
      file.write("#{i} #{s}\n")
    end
  end

end

=end