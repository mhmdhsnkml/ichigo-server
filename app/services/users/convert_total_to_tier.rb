module Users
  class ConvertTotalToTier < ApplicationService
    attr_reader :total

    def initialize(total)
      @total = total
    end

    def call
      if @total >= User::GOLD_TIER
        'gold'
      elsif @total >= User::SILVER_TIER
        'silver'
      else
        'bronze'
      end
    end
  end
end
