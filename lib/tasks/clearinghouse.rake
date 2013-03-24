namespace :clearinghouse do

  task :hourly_push => :environment do
    ClearingHouse::BillPublisher.new.publish
  end

end
