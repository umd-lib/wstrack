require 'test_helper'

# Tests for CurrentStatus model validations.
class CurrentStatusTest < ActiveSupport::TestCase
  def setup
    @status = CurrentStatus.new(workstation_name: 'LIBRWKARCP1F5A', status: 'login', os: 'Windows_NT',
                                user_hash: 'LakJJ6PHPreRRBicGqHBxA==', guest_flag: false)
  end

  test 'workstation_name should not be absent' do
    @status.workstation_name = nil
    assert_not @status.valid?
  end

  test 'status should not be absent' do
    @status.status = nil
    assert_not @status.valid?
  end

  test 'os should not be absent' do
    @status.os = nil
    assert_not @status.valid?
  end

  test 'user_hash should not be absent' do
    @status.user_hash = nil
    assert_not @status.valid?
  end

  test 'guest_flag should not be absent' do
    @status.guest_flag = nil
    assert_not @status.valid?
  end

  test 'valid record should be accepted' do
    assert @status.valid?
  end

  test 'duplicate workstation_name should be rejected' do
    @status.save
    dup = @status.dup
    assert_not dup.valid?
  end

  test 'duplicate workstation_name with different case should be rejected' do
    @status.save
    dup = @status.dup
    dup.workstation_name.swapcase!
    assert_not dup.valid?
  end

  test 'invalid workstation_name should be rejected' do
    @status.workstation_name = 'SOMEINVALIDNAME'
    assert_not @status.valid?
  end
end
