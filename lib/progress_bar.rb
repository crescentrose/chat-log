 # stolen from https://coderwall.com/p/ijr6jq/rake-progress-bar
 class ProgressBar

  def initialize(total)
    @total   = total
    @counter = 1
  end

  def increment
    complete = sprintf("%#.2f%%", ((@counter.to_f / @total.to_f) * 100))
    print "\r\e[0K#{@counter}/#{@total} (#{complete})"
    @counter += 1
  end
end
