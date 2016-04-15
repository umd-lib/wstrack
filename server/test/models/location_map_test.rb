require 'test_helper'

# Tests for LocationMap model validations.
class LocationMapTest < ActiveSupport::TestCase
  def setup
    @location_map = LocationMap.new(code: 'MCK1F', value: 'Mckeldin Second Floor', regex: '/(?i)^LIBRWKMCK[PM]2F.*$/')
  end

  test 'code should not be absent' do
    @location_map.code = nil
    assert_not @location_map.valid?
  end

  test 'value should not be absent' do
    @location_map.value = nil
    assert_not @location_map.valid?
  end

  test 'regex should not be absent' do
    @location_map.regex = nil
    assert_not @location_map.valid?
  end

  test 'invalid regex should be rejected' do
    invalid_regexes = %w[/(/ /no-ending-slash no-starting-slash/ no-slash]
    invalid_regexes.each do |invalid_regex|
      @location_map.regex = invalid_regex
      assert_not @location_map.valid?
    end
  end

  test 'valid record should be accepted' do
    assert @location_map.valid?
  end

  test 'duplicate regex should be rejected' do
    @location_map.save
    dup = @location_map.dup
    assert_not dup.valid?
  end
end
