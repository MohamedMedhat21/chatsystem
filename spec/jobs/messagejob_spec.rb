require 'rails_helper'
require 'sidekiq/testing' 
RSpec.describe Message, type: :job do
  describe "message creation job" do
    it "enqueue message creation job" do
      expect {
        MessageCreationJob.perform_async(1, 1,"hello")
      }.to change(MessageCreationJob.jobs, :size).by(1)
      MessageCreationJob.perform_async(1, 2,"hello2")
      MessageCreationJob.perform_async(2, 3,"hello2")
      assert_equal 3, MessageCreationJob.jobs.size
      MessageCreationJob.drain
      assert_equal 0, MessageCreationJob.jobs.size
    end
  end
end
