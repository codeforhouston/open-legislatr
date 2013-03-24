class OpenStates::AttributeComparison < Struct.new(:legislation, :current_bill)



  def changes
    OpenStates::MONITORED_ATTRIBUTES.each_with_object([]) do |attr_name, collection|
      collection << attr_name
    end.flatten
  end


end
