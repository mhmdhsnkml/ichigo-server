module Users
  class Update < ApplicationService
    attr_reader :user, :params

    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      is_success = @user.update(@params)

      [is_success, @user]
    end
  end
end
