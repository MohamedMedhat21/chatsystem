task :es_create_index => :environment do
    Message.__elasticsearch__.create_index!
    Message.__elasticsearch__.refresh_index!
    Message.import
end