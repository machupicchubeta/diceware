# frozen_string_literal: true

require 'pathname'
require 'securerandom'

class Diceware
  class << self
    def passphrase
      to_s phrases(tapp(seeds))
    end

    def seed random
      Array.new(5) { random.rand(1..6) }.join
    end

    def seeds
      random = Random.new(Time.now.to_f)
      Array.new(5) { seed(random) }
    end

    def phrases numbers
      json = File.readlines(Pathname.new(File.dirname($PROGRAM_NAME)).join('diceware.wordlist.asc'))

      Array.new(numbers.size) do |index|
        json.grep(/\A#{numbers[index]}/).first.split("\t").first(2).last.chop
      end
    end

    def to_s array
      p array.join '-'
    end

    def tapp array
      to_s array

      array
    end
  end
end

Diceware.passphrase
