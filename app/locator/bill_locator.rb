class Locator::BillLocator

  attr_reader :tags, :bills

  def initialize
    @tags = Tag.all
    @bills = []
  end


  def locate
    sources.each do |data_source|
      @tags.each do |tag|
        @bills << data_source.bills_updated_since(Time.zone.now - 1.month, tag.name)
      end
    end

    @bills.flatten.each do |bill|
      create_initial_events if bill.new_record? and bill.save
    end
  end


private

  def sources
    [ Locator::Sources::OpenStates.new ]
  end

end