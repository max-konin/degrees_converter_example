require 'byebug'

class Temperature
  RULES = [
    { from: 'C', to: 'F', func: ->(value) { value * 1.8 + 32  } },
    { from: 'F', to: 'C', func: ->(value) { (value - 32) / 1.8  } },
    { from: 'C', to: 'K', func: ->(value) { value + 273.15  } },
    { from: 'K', to: 'C', func: ->(value) { value - 273.15  } },
    { from: 'K', to: 'F', func: ->(value) { Temperature.new(value).from('K').to('C').to('F').value } },
    { from: 'F', to: 'K', func: ->(value) { Temperature.new(value).from('F').to('C').to('K').value } }
  ].freeze

  attr_reader :value

  def initialize(value, from = nil, to = nil)
    @value = value
    @from = from
    @to = to
    convert! if !@to.nil? && !@from.nil? && @from != @to
  end

  def from(from)
    Temperature.new(@value, from, @to)
  end

  def to(to)
    Temperature.new(@value, @from, to)
  end

  private

  def convert!
    rule = RULES.find { |rule| rule[:from] == @from && rule[:to] == @to }
    @value = rule[:func].call(@value)
    @from = @to
    @to = nil
  end
end
