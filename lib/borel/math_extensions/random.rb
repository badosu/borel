require 'borel'

module Borel
  module MathExtensions
    module Random
      def random
      end
    end
  end
end

class Interval
  include Borel::MathExtensions::Random
end
