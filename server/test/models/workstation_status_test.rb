# frozen_string_literal: true

require 'test_helper'

class WorkstationStatusTest < ActiveSupport::TestCase
  def setup
    @current_storage_dir = Rails.configuration.x.history.storage_dir
  end

  def teardown
    Rails.configuration.x.history.storage_dir = @current_storage_dir
  end

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

  test 'new entry is recorded to history after commit' do
    Dir.mktmpdir do |temp_dir|
      Rails.configuration.x.history.storage_dir = temp_dir

      os = 'Mac OS X 10.15.3'
      encoded_os = CGI.escape(os)

      travel_to Time.parse('April 22, 2022 13:00:00 EDT') do
        workstation_status = WorkstationStatus.new(
          workstation_name: 'LIBRWKSTEMM3F383',
          os: encoded_os,
          user_hash: 'y3Fu6SqTdoGUdaERmrF4SA==',
          status: 'login',
          guest_flag: 'true'
        )

        workstation_status.save!
      end

      expected_storage_path = Pathname.new(temp_dir).join('2022-04-22.csv')
      assert expected_storage_path.size? # File exists and has non-zero size
    end
  end

  test 'new entry with error is not recorded to history' do
    Dir.mktmpdir do |temp_dir|
      Rails.configuration.x.history.storage_dir = temp_dir

      travel_to Time.parse('April 22, 2022 13:00:00 EDT') do
        workstation_status = WorkstationStatus.new(
          user_hash: 'y3Fu6SqTdoGUdaERmrF4SA==',
          status: 'login',
          guest_flag: 'true'
        )

        workstation_status.save
        assert workstation_status.errors.any?
      end

      expected_storage_path = Pathname.new(temp_dir).join('2022-04-22.csv')
      assert_not expected_storage_path.exist?
    end
  end

  test 'edited entry is not recorded to history' do
    Dir.mktmpdir do |temp_dir|
      Rails.configuration.x.history.storage_dir = temp_dir

      workstation_status = workstation_statuses(:epl_mac_ws)
      workstation_status.os = 'PC'
      workstation_status.save!

      assert Dir.empty?(temp_dir), 'Entry should not have been written to history file.'
    end
  end
end
