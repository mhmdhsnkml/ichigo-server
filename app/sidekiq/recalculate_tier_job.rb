class RecalculateTierJob
  include Sidekiq::Job

  def perform
    RecalculateTier.call
  end
end
