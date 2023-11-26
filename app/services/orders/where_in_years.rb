module Orders
  class WhereInYears < ApplicationService
    attr_reader :user_id, :range, :offset, :limit

    def initialize(user_id, range, offset = 1, limit = 5, is_count = false)
      @user_id = user_id
      @range = range
      @limit = limit.nil? ? 5 : limit.to_i
      @offset = offset.nil? ? 1 : offset.to_i
      @is_count = is_count.nil? ? false : is_count
    end

    def call
      total = Order.where(customer_id: @user_id).where("ordered_at > ?", Time.now.utc.beginning_of_year - (@range - 1).year).count if @is_count
      orders = Order.where(customer_id: @user_id).where("ordered_at > ?", Time.now.utc.beginning_of_year - (@range - 1).year).limit(@limit).offset((@offset - 1) * @limit)

      meta_pagination = {
        total: @is_count ? total : orders.count,
        limit: @limit,
        offset: @offset
      }

      [orders, meta_pagination]
    end
  end
end
