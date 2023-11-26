module Users
  class AmountToSpendToKeepTier < ApplicationService
    attr_reader :total, :tier

    def initialize(total, tier)
      @total = total
      @tier = tier
    end

    def call
      amount = case @tier
      when 'gold'
        User::GOLD_TIER - @total
      when 'silver'
        User::SILVER_TIER - @total
      when 'bronze'
        User::BRONZE_TIER - @total
      end

      amount <= 0 ? 0 : amount
    end
  end
end
