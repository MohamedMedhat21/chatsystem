namespace :es do
  desc "TODO"
  task create_index: :environment do
    Message.__elasticsearch__.create_index! force:true
    Message.__elasticsearch__.refresh_index!
    Message.import
  end
end
