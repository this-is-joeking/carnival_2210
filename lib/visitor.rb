class Visitor
  attr_reader :name,
              :height,
              :preferences
  attr_accessor :spending_money

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = format_money(spending_money)
    @preferences = []
  end

  def format_money(string)
    return string[1..].to_i if string.is_a?(String) && string[0] == '$'
    
    string.to_i
  end

  def add_preference(preference)
    @preferences << preference
  end

  def tall_enough?(ht_req)
    @height >= ht_req
  end

  def excited_enough?(excitement)
    @preferences.include?(excitement)
  end

  def rich_enough?(admission_fee)
    spending_money - admission_fee >= 0
  end
end
