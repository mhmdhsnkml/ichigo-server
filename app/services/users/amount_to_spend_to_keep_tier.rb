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
        50000 - @total
      when 'silver'
        10000 - @total
      when 'bronze'
        0 - @total
      end

      amount <= 0 ? 0 : amount
    end
  end
end
