class Clearinghouse::BillPublisher

  BLOG_NAME = 'openlegislatr.tumblr.com'

  def initialize
    @client = Tumblr::Client.new
  end


  def publish(event)
    @client.text( BLOG_NAME,
                  title: "Update regarding #{event.legislation.state.upcase} #{event.legislation.bill_id}",
                  body: text_from_event(event))
    # Publish each even via each format.
  end


  def text_from_event(event)
    (event.changes.map { |c| "#{c.key.titleize} has changed to #{c.to}" }).join('<br>')
  end

private

  def formats
    [ Clearinghouse::Formats::Tumblr.new ]
  end


end