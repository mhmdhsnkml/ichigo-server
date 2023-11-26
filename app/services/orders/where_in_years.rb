module Orders
  class WhereInYears < ApplicationService
    attr_reader :user_id, :range

    def initialize(user_id, range)
      @user_id = user_id
      @range = range
    end

    def call
      Order.where(customer_id: @user_id).where("ordered_at > ?", Time.now.utc.beginning_of_year - (@range - 1).year)
    end
  end
end
