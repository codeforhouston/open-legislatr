namespace :locator do

  task :hourly_locate => :environment do
    Locator::BillLocator.new.locate
  end

end
