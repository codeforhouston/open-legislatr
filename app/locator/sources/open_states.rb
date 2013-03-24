class Locator::Sources::OpenStates


  def initialize(state = 'tx', subject = 'Health', session = '83')
    @state = state
    @subject = subject
  end


  def bills_updated_since(time = Time.zone.today - 1.day, tags)
    tags = [*tags]
    options = {subject: @subject, state: @state}
    options[:q] = tags unless tags.blank?
    results_to_legislations GovKit::OpenStates::Bill.latest(time, options)
  end


private

  def results_to_legislations(results)
    bills_only(results).each_with_object([]) do |collection, result|
      collection << build_legislation(result)
    end
  end


  def bills_only(results)
    results.select { |result| result.type.contain? 'bill' }
  end


  def build_legislation(os_result)
    Legislation.create(
      bill_id: os_result.bill_id ,
      source: 'OpenStates',
      identifier_at_source: os_result.id,
      session: os_result.session
      state: os_result.state
      chamber: os_result.chamber)
  end

end
