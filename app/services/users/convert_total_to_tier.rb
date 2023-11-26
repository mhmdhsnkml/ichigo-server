module Users
  class ConvertTotalToTier < ApplicationService
    attr_reader :total

    def initialize(total)
      @total = total
    end

    def call
      if @total >= 50000
        'gold'
      elsif @total >= 10000
        'silver'
      else
        'bronze'
      end
    end
  end
end
