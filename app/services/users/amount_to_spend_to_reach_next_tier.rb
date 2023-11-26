module Users
  class AmountToSpendToReachNextTier < ApplicationService
    attr_reader :total

    def initialize(total)
      @total = total
    end

    def call
      if total >= 50000
        0
      elsif total >= 10000
        50000 - total
      else
        10000 - total
      end
    end
  end
end
