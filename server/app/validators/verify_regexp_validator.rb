class VerifyRegexpValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if !record.regex || record.regex[0] != '/' || record.regex[-1] != '/'
      record.errors[attribute] << (options[:message] || "should begin and end with '/'")
    else
      begin 
        # Use [1..-2] to strip the beginning and ending /
        # /something/ will become something
        Regexp.new record.regex[1..-2]
      rescue => error
        record.errors[attribute] << (options[:message] || "#{error.message}")
      end
    end
  end
end