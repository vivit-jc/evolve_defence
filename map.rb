class Map
attr_reader :map
  def initialize
    @map = []
    open("./map.csv") do |file|
      while l = file.gets
        @map.push l.strip.split(",").map{|c|c.to_i}
      end
    end
  end

end