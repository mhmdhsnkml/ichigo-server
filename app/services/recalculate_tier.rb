class RecalculateTier < ApplicationService
  def call
    User.find_each(batch_size: 100) do |user|
      total = Orders::CalculateTierTotal.call(user, 2)
      tier = Users::ConvertTotalToTier.call(total)

      if user.tier != tier
        Users::Update.call(user, { tier: tier })
      end
    end
  end
end
