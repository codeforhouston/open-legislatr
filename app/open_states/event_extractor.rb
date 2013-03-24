class OpenStates::EventExtractor

  attr_reader :legislation, :os_bill

  def initialize(legislation)
    @legislation = legislation
    @os_bill = GovKit::OpenStates::Bill.find( @legislation.state,
                                              @legislation.session,
                                              @legislation.bill_id,
                                              @legislation.chamber)
  end


  def create_initial_events
    changes = build_changes(true)
    if changes.any?
      event = Event.create(legislation: @legislation)
      changes.each do |change|
        change.event_id = event.id
        change.save
      end
    end
  end


  def build_changes(initial = false)
    ::OpenStates::MONITORED_ATTRIBUTES.each_with_object([]) do |attr_name, changes|
      changes << changes_from_attr(attr_name, initial)
    end.flatten
  end


  def changes_from_attr(attr_name, initial = false)
    self.send "#{attr_name}_changes", initial
  end


  def sponsors_changes(initial = false)
    if initial
      Change.new( key: 'sponsors',
                  from: '',
                  to: @os_bill.sponsors.map(&:name).join(' ') )
    end
  end


  def version_changes(initial = false)
    if initial
      # This currently does not account for properly ordering the versions
      # and place each in a sensible from & to format.
      @os_bill.versions.each_with_object([]) do |version, collection|
        collection << Change.new( key: 'version',
                                  from: '',
                                  to: version.doc_id )
      end
    end
  end


  def action_changes(initial = false)
    if initial
      # This currently does not account for properly ordering the versions
      # and place each in a sensible from & to format.
      @os_bill.actions.each_with_object([]) do |action, collection|
        collection << Change.new( key: 'action',
                                  from: '',
                                  to: action.type.join(' ') )
      end
    end
  end


end