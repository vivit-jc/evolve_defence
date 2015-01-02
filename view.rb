# encoding: utf-8

# -*- coding: utf-8 -*-
class View

  def initialize(game,controller)
    @game = game
    @controller = controller
  end

  def draw
    case @game.state
    when :title
      draw_title
    when :game
      draw_game
    when :load
    when :save
      draw_savedata
    when :end
      draw_ending
    end
  end

  def draw_title
    Window.drawFont(70, 10, "EVOLVE_DEFENCE", Font60)
    TITLEMENU_TEXT.each_with_index do |menu,i|
      Window.drawFont(TITLEMENU_X, TITLEMENU_Y[i],menu,Font32,font_yellow(@controller.pos_menu == i))
    end
  end

  def draw_game
    Window.drawFont(20,15,"PAUSE",Font20) if(@game.pause)
    draw_main
    draw_clock
    draw_status
    draw_menu
    draw_textbox
    draw_icon

  end

  def draw_main
    Window.draw(MAIN_X,MAIN_Y,MAIN)
  end

  def draw_clock
    Window.draw_font(CLOCK_X,CLOCK_Y,@game.datetime,Font20)
    
  end

  def draw_status
    Window.draw_font(STATUS_X,STATUS_Y,"資金: #{@game.money}",Font20)
    Window.draw_font(STATUS_X,STATUS_Y+16,"政治力: #{@game.polit}",Font20)
    
  end

  def draw_menu
    MENU.each_with_index do |menu,i|
      Window.draw(MENU_X,MENU_Y[i],menu)
      Window.draw_font(MENU_X+5,MENU_Y[i]+2,MENU_TEXT[i],Font20)
    end
  end

  def draw_icon
    Window.draw(ICON_X,ICON_Y,ICON)
  end

  def draw_textbox
    Window.draw(TEXTBOX_X,TEXTBOX_Y,TEXTBOX)
  end

  def draw_ship_alt(n)
    Window.drawFont(SHIPS_X[n]+4,SHIPS_ALT_Y+7,"Lv."+@game.ships[n].level.to_s,Font16)
    alt_str = @game.ships[n].level > 0 ? "改造" : "購入"
    fonthash = {}
    fonthash = {color: RED} if(@game.money < @game.ships[n].levelup_cost)
    fonthash = {color: GRAY} if(@game.infishing?)
    Window.drawFont(SHIPS_X[n]+45,SHIPS_ALT_Y+10,alt_str+@game.ships[n].levelup_cost.to_s,Font12,fonthash)
  end

  def draw_ship(n)
    if(@game.ships[n].level==0)
      ship_status = ""
    else
      ship_status = @game.infishing? ? "作業中" : "停泊中"
    end
    Window.drawFont(SHIPS_X[n]+6,SHIPS_Y+10,ship_status,Font16)
  end

  def draw_ranking
    Window.drawFont(200,40,"RANKING",Font60)
    @game.ranking.each_with_index do |r,i|
      Window.drawFont(250,120+40*i,(i+1).to_s+". "+r.to_s,Font32)
    end
    fonthash = {}
    fonthash = {color: YELLOW} if(@controller.pos_return)
    Window.drawFont(250,400,"戻る",Font20,fonthash)
  end

  def draw_ending
    Window.drawFont(140,40,"GAME OVER",Font60)
    Window.drawFont(200,120,"score: "+@game.score.to_s,Font32)
    Window.drawFont(170,180,"ハイスコアを更新しました！",Font20,{color: [0,255,0]}) if(@game.new_rank)
    fonthash = {}
    fonthash = {color: YELLOW} if(@controller.pos_return)
    Window.drawFont(250,400,"戻る",Font20,fonthash)
  end

  def font_yellow(bool)
    bool ? {color: YELLOW} : {}
  end

end