namespace :monitor do

  task :hourly_update => :environment do
    Monitor::BillMonitor.new.update
  end

end
