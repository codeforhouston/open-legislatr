class Monitor::BillMonitor

  def initialize
    @bills = Legislations.all
  end


  def update
    sources.each do |data_source|
      data_source.determine_events @bills
    end
  end


private

  def sources
    [ Locator::Sources::OpenStates.new ]
  end

end
