class Monitor::Sources::OpenStates

  def initialize(bills)
    @bills = bills
  end


  def determine_events
    events = @bills.map do |bill|
      build_event_from_differences(bill, current_bill_details(bill))
    end
    events.select { |event| !event.nil? }
  end


private

  def current_bill_details(bill)
    GovKit::OpenStates::Bill.find(bill.state, bill.session, bill.bill_id, bill.chamber)
  end


  def build_event_from_differences(bill, bill_query_results)
    changes = AttributeComparison.new(bill, bill_query_results).changes
    changes.any? ? build_event_with_changes(bill, changes) : nil
  end


  def build_event_with_changes(bill, changes)
    return nil if changes.blank?
    event = Event.create(legislation: bill)
    changes.each do |change|
      change.event = event
      change.save
    end
  end




  class Monitor::AttributeComparison < Struct.new(:legislation, :current_bill)

    MONITORED_ATTRIBUTES = ['', '', '', '']

    def changes

    end
  end

end