require 'rails_helper'
require 'sidekiq/testing' 
RSpec.describe Chat, type: :job do
  describe "chat creation job" do
    it "enqueue chat creation job" do
      expect {
        ChatCreationJob.perform_async(1, 1)
      }.to change(ChatCreationJob.jobs, :size).by(1)
      ChatCreationJob.perform_async(1, 2)
      ChatCreationJob.perform_async(2, 3)
      assert_equal 3, ChatCreationJob.jobs.size
      ChatCreationJob.drain
      assert_equal 0, ChatCreationJob.jobs.size
    end
  end
end
