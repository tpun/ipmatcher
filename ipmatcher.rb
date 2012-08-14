class IPMatcher
  attr_reader :patterns
  def initialize
    @patterns = {}
  end

  def add pattern
    sub_patterns = pattern.split('.')
    start = @patterns
    while sub_patterns.count > 0
      sub_pattern = sub_patterns.shift
      if sub_patterns.count==0 || sub_pattern=='*'
        start[sub_pattern] = true
      else
        start[sub_pattern] ||= Hash.new
      end
      start = start[sub_pattern]
    end
  end

  def match? pattern
    sub_patterns = pattern.split('.')
    return false if sub_patterns.count != 4

    start = @patterns
    while sub_patterns.count > 0
      sub_pattern = sub_patterns.shift
      return false if start[sub_pattern].nil?
      return true if start[sub_pattern] == true
      return true if start[sub_pattern]['*'] == true

      start = start[sub_pattern]
    end

    false
  end
end