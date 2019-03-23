require 'rubygems'
require 'bundler/setup'
require 'colorize'


class Tile

  attr_reader :value, :given

  def initialize(value)
    @value = value
    value.to_i == 0 ? @given = true : @given = false
  end


  def value=(value)
    @given ? @value = value : (raise "Unchangeable tile!!")
  end

  def to_s
    @given ? (print @value.colorize(:red)) : (print @value)
  end

end