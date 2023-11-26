class OrdersController < ApplicationController
  def create
    user = Users::FindBy.call({ id: order_params[:customer_id] })
    return render json: { error: 'Customer not found' }, status: 422 unless user

    is_success, order = Orders::Create.call(build_create_params)
    return render json: { error: 'Failed to create order' }, status: 422 unless is_success

    total = Orders::CalculateTierTotal.call(user, 2)
    tier = Users::ConvertTotalToTier.call(total)

    puts "TOTAL: #{total} | TIER: #{tier}"

    if user.tier != tier
      is_success, user = Users::Update.call(user, { tier: tier })
      return render json: { error: 'Failed to update tier' }, status: 422 unless is_success
    end

    render json: order
  end

  private

  def build_create_params
    {
      order_uniq_id: order_params[:order_id],
      customer_name: order_params[:customer_name],
      total_in_cents: order_params[:total_in_cents],
      ordered_at: order_params[:date],
      customer_id: order_params[:customer_id]
    }
  end

  def order_params
    params.permit(:customer_id, :customer_name, :order_id, :total_in_cents, :date)
  end
end
