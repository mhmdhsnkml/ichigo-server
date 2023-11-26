module Users
  class FindBy < ApplicationService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      ::User.find_by(@params)
    end
  end
end
