require 'sidekiq-scheduler'
class UpdatecntsWorkerJob
    include Sidekiq::Job
    sidekiq_options retry:0
    
    def perform()
        `rake repeated:update_counts`
    end
        
  end