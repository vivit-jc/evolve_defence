# encoding: utf-8

class Controller
  attr_reader :x,:y,:mx,:my

  def initialize(game)
    @game = game
    @mxbuf = 0
    @mybuf = 0
  end

  def input
    @mx = Input.mousePosX
    @my = Input.mousePosY
    SMENU.play if(mouseover?(:menu))
    if Input.mouse_push?( M_LBUTTON )
      case @game.state
      when :title
        act_titlemenu(pos_titlemenu)
      when :game
        @game.menu(pos_menu)
      when :ranking
        @game.go_title if(pos_return)
      when :end
        @game.next if(pos_return)
      end
    end
    if(Input.key_push?(K_Z))
      case @game.state
      when :game
        @game.sell_all_fish
      end
    end
    if(Input.key_push?(K_SPACE))
      case @game.state
      when :game
        @game.toggle_pause
      end
    end
    if(Input.key_push?(K_ESCAPE))
      exit
    end
    @mxbuf = @mx
    @mybuf = @my
  end

  def mouseover?(pos)
    case(pos)
    when :menu
      if(pos_menu != -1)
        SMENU.play unless(mbufcheck(MENU_X,MENU_X+100,MENU_Y[pos_menu],MENU_Y[pos_menu]+MENU_HEIGHT))
      end
    end
  end

  def act_titlemenu(pos)
    case(pos)
    when 0
      @game.start
    when 1
      @game.loaddata
    when 2
      exit
    end
  end

  def pos_titlemenu
    TITLEMENU_TEXT.each_with_index do |t,i|
      return i if(mcheck(TITLEMENU_X, TITLEMENU_X+Font32.get_width(t), TITLEMENU_Y[i], TITLEMENU_Y[i]+32))
    end
    return -1
  end

  def pos_menu
    MENU.size.times do |i|
      return i if(mcheck(MENU_X,MENU_X+100,MENU_Y[i],MENU_Y[i]+MENU_HEIGHT))
    end
    return -1
  end

  def pos_ship
    4.times do |i|
      return i if(mcheck(SHIPS_X[i],SHIPS_X[i]+100,SHIPS_Y,SHIPS_Y+100))
    end
    return -1
  end

  def pos_ship_alt
    4.times do |i|
      return i if(mcheck(SHIPS_X[i],SHIPS_X[i]+100,SHIPS_ALT_Y,SHIPS_ALT_Y+30))
    end
    return -1
  end

  def pos_return
    mcheck(250,250+Font20.get_width("戻る"),400,420)
  end

  def mcheck(x1,x2,y1,y2)
    x1 < @mx && x2 > @mx && y1 < @my && y2 > @my
  end

  def mbufcheck(x1,x2,y1,y2)
      x1 < @mxbuf && x2 > @mxbuf && y1 < @mybuf && y2 > @mybuf
  end

end