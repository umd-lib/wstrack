# Validates if the given value is a valid regular expression.
class VerifyRegexpValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.nil?
      check_slash_delimited(record, attribute, value)
      check_instanitiation(record, attribute, value)
    end
  end

  def check_slash_delimited(record, attribute, value)
    if value[0] != '/' || value[-1] != '/'
      record.errors[attribute] << (options[:message] || 'should be delimted with /')
    end
  end

  def check_instanitiation(record, attribute, value)
    # Use [1..-2] to strip the beginning and ending /
    # /something/ will become something
    Regexp.new value[1..-2]
  rescue => error
    record.errors[attribute] << (options[:message] || error.message.to_s)
  end
end
