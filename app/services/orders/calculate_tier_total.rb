module Orders
  class CalculateTierTotal < ApplicationService
    attr_reader :user, :start_date
  
    def initialize(user, range)
      @user = user
      @start_date = Time.now.utc.beginning_of_year - (range - 1).year
    end
  
    def call
      @user.orders.where("ordered_at > ?", @start_date).sum(:total_in_cents)
    end
  end
end
