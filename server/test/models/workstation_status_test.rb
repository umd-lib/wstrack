# frozen_string_literal: true

require 'test_helper'

class WorkstationStatusTest < ActiveSupport::TestCase
  test '"os" param is URL-decoded on save' do
    os = 'Mac OS X 10.15.3'
    encoded_os = CGI.escape(os)

    workstation_status = WorkstationStatus.new(
      workstation_name: 'LIBRWKSTEMM3F383',
      os: encoded_os,
      user_hash: 'y3Fu6SqTdoGUdaERmrF4SA==',
      status: 'login',
      guest_flag: 'true'
    )

    workstation_status.save!
    assert_equal(os, workstation_status.os)

    # If an "os" is provided with spaces, it is unchanged
    workstation_status.os = 'Test OS with Spaces'
    workstation_status.save!
    assert_equal('Test OS with Spaces', workstation_status.os)
  end
end
