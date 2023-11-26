class UsersController < ApplicationController
  def index
    users = User.all

    render json: users
  end

  def show
    user = User.find_by(id: params[:id])

    if user
      total_spent_in_2_years = Orders::CalculateTierTotal.call(user, 2)
      amount_to_spent_to_reach_next_tier = Users::AmountToSpendToReachNextTier.call(total_spent_in_2_years)
      total_spent_in_1_year = Orders::CalculateTierTotal.call(user, 1)
      grade_for_next_year = Users::ConvertTotalToTier.call(total_spent_in_1_year)
      the_date_of_new_tier = Time.now.utc.beginning_of_year + 1.year
      amount_to_spend_to_keep_tier = Users::AmountToSpendToKeepTier.call(total_spent_in_1_year, user.tier)

      render json: user.as_json.merge({
        start_date_tier_calculation: Time.now.utc.beginning_of_year - 1.year,
        total_spent_in_2_years: total_spent_in_2_years,
        amount_to_spent_to_reach_next_tier: amount_to_spent_to_reach_next_tier,
        grade_for_next_year: grade_for_next_year == user.tier ? nil : grade_for_next_year,
        the_date_of_new_tier: the_date_of_new_tier,
        amount_to_spend_to_keep_tier: amount_to_spend_to_keep_tier
      })
    else
      render json: { error: 'User not found' }, status: 404
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: { error: 'Unable to create User' }, status: 400
    end
  end

  def destroy
    user = User.find_by(id: params[:id])

    if user
      if user.destroy
        render json: user
      else
        render json: { error: 'Unable to delete User' }, status: 400
      end
    else
      render json: { error: 'User not found' }, status: 422
    end
  end

  def recalculate_tier
    RecalculateTierJob.perform_async
    render json: { message: 'Successfully enqueued' }
  end

  def orders
    user = Users::FindBy.call({ id: params[:id] })

    if user
      orders = Orders::WhereInYears.call(user.id, 2)

      render json: orders
    else
      render json: { error: 'User not found' }, status: 404
    end
  end

  private

  def user_params
    params.permit(:name)
  end
end
