class Locator::BillLocator

  attr_reader :tags, :bills

  def initialize
    @tags = Tag.all
    @bills = []
  end


  def locate(since_time = Time.zone.today - 1.day)
    sources.each do |data_source|
      @tags.each do |tag|
        @bills << data_source.bills_updated_since(since_time, tag.name)
      end
    end
    @bills = @bills.flatten
  end

private

  def sources
    [ Locator::Sources::OpenStates.new ]
  end

end