module Orders
  class Create < ApplicationService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      order = Order.new(@params)
      is_success = order.save

      [is_success, order]
    end
  end
end
