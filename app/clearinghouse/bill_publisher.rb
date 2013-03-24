class ClearingHouse::BillPublisher

  def initialize
    # Fetch events created in the last hour.
  end


  def publish
    # Publish each even via each format.
  end

private

  def formats
    [ Clearinghouse::Formats::Tumblr.new ]
  end


end