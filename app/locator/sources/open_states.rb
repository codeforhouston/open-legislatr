class Locator::Sources::OpenStates

  attr_reader :results

  def initialize(state = 'tx', subject = 'Health', session = '83')
    @default_query_options = { state: state, subject: subject, session: session }
  end


  def bills_updated_since(time = Time.zone.today - 1.day, tag)
    options = tag.blank? ? @default_query_options : @default_query_options.merge({q: tag})
    @results = GovKit::OpenStates::Bill.latest(time, options)
    legislations = results_to_legislations @results
  end


private

  def results_to_legislations(results)
    bills_only(results).each_with_object([]) do |result, collection|
      collection << create_legislation(result)
    end
  end


  def bills_only(results)
    results.select { |result| result.type.include? 'bill' }
  end


  def create_legislation(os_result)
    legislation = Legislation.find_or_initialize_by_bill_id(os_result.bill_id)
    if legislation.new_record?
      legislation.attributes = {
        bill_id: os_result.bill_id,
        source: 'OpenStates',
        identifier_at_source: os_result.id,
        session: os_result.session,
        state: os_result.state,
        chamber: os_result.chamber
      }
      if legislation.save
        ::OpenStates::EventExtractor.new(legislation).create_initial_events
      end
    end
    return legislation
  end

end
