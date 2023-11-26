module Users
  class AmountToSpendToReachNextTier < ApplicationService
    attr_reader :total

    def initialize(total)
      @total = total
    end

    def call
      if total >= User::GOLD_TIER
        0
      elsif total >= User::SILVER_TIER
        User::GOLD_TIER - total
      else
        User::SILVER_TIER - total
      end
    end
  end
end
