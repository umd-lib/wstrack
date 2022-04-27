# frozen_string_literal: true

require 'test_helper'

class RecordHistoryTest < ActiveSupport::TestCase
  test 'filename uses local timezone for generating filenames' do
    record_history = RecordHistory.new

    # Following assumes local timezone is 'Eastern Time (US & Canada)'
    test_cases = [
      { timestamp: Time.parse('April 22, 2022 00:00:00 UTC'), expected: '2022-04-21.csv' },
      { timestamp: Time.parse('April 22, 2022 03:59:59 UTC'), expected: '2022-04-21.csv' },
      { timestamp: Time.parse('April 22, 2022 04:00:00 UTC'), expected: '2022-04-22.csv' },
      { timestamp: Time.parse('January 1, 2023 00:00:00 UTC'), expected: '2022-12-31.csv' },
      { timestamp: Time.parse('January 1, 2023 04:59:59 UTC'), expected: '2022-12-31.csv' },
      { timestamp: Time.parse('January 1, 2023 05:00:00 UTC'), expected: '2023-01-01.csv' },

      { timestamp: Time.parse('April 22, 2022 00:00:00 EDT'), expected: '2022-04-22.csv' },
      { timestamp: Time.parse('April 22, 2022 23:59:59 EDT'), expected: '2022-04-22.csv' },
      { timestamp: Time.parse('January 1, 2023 00:00:00 EST'), expected: '2023-01-01.csv' }
    ]

    test_cases.each do |test|
      expected_filename = test[:expected]
      actual_filename = record_history.filename(test[:timestamp])
      assert_equal expected_filename, actual_filename, "timestamp: #{test[:timestamp]}"
    end
  end

  test 'as_csv returns a Hash of WorkstationStatus info record' do
    workstation_status = WorkstationStatus.new(
      {
        workstation_name: 'LIBRWKARTM1F123', os: 'Mac OS X 10.15.3',
        user_hash: 'y3Fu6SqTdoGUdaERmrF4SA==', status: 'login',
        guest_flag: true
      }
    )
    workstation_status.save!

    timestamp = Time.zone.now
    csv_hash = RecordHistory.new.as_csv(workstation_status, timestamp)

    expected_hash = {
      workstation_name: 'LIBRWKARTM1F123',
      os: 'Mac OS X 10.15.3', user_hash: 'y3Fu6SqTdoGUdaERmrF4SA==',
      status: 'login', guest_flag: 't', location: 'Art Library 1st floor',
      type: 'MAC', timestamp: timestamp.strftime('%Y-%m-%d %H:%M:%S.%L')
    }

    assert_equal expected_hash, csv_hash
  end

  test 'as_csv returns empty location and type when not populated in WorkstationStatus' do
    workstation_status = WorkstationStatus.new(
      {
        workstation_name: 'TEST', os: 'Mac OS X 10.15.3',
        user_hash: 'y3Fu6SqTdoGUdaERmrF4SA==', status: 'login',
        guest_flag: true
      }
    )

    workstation_status.save!

    timestamp = Time.zone.now
    csv_hash = RecordHistory.new.as_csv(workstation_status, timestamp)

    expected_hash = {
      workstation_name: 'TEST',
      os: 'Mac OS X 10.15.3', user_hash: 'y3Fu6SqTdoGUdaERmrF4SA==',
      status: 'login', guest_flag: 't', location: nil,
      type: nil, timestamp: timestamp.strftime('%Y-%m-%d %H:%M:%S.%L')
    }

    assert_equal expected_hash, csv_hash
  end
end
