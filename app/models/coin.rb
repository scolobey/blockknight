class Coin < ApplicationRecord
  def increased?
    puts percent_change.class, percent_change
    if percent_change && percent_change > 0
      puts 'true'
      return true
    else
      puts 'false'
      return false
    end
  end
end
