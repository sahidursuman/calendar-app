class TimeRange < Struct.new(:start_time, :end_time)

  include Comparable

  def <=>(other)
    self.start_time <=> other.start_time
  end

  def ==(other)
    self.start_time == other.start_time and self.end_time == other.end_time
  end

  def overlap?(other)
    a, b = [self, other].sort
    a.end_time > b.start_time
  end

  def in_range?(other)
    (self.start_time <= other.start_time) && (self.end_time >= other.end_time) 
  end

  alias_method :overlaps?, :overlap?
  alias_method :conflicts?, :overlap?

  def length
    end_time - start_time
  end

end