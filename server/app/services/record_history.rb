# frozen_string_literal: true

require 'csv'

# Records workstation status records in a CSV-formatted history file.
class RecordHistory < ApplicationService
  # Mutex to prevent multiple threads from writing to the file simultaneously
  @semaphore = Mutex.new

  class << self
    attr_reader :semaphore
  end

  def perform(workstation_status)
    return unless new_record?(workstation_status)

    self.class.semaphore.synchronize do
      timestamp = workstation_status.updated_at
      csv_record = as_csv(workstation_status, timestamp)
      write_to_file(timestamp, csv_record)
    end
  end

  # Returns true if the given WorkstationStatus is a newly-created record,
  # false otherwise.
  def new_record?(workstation_status)
    workstation_status.saved_change_to_id?
  end

  # Returns a Hash representing the CSV row to record
  def as_csv(workstation_status, timestamp) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    csv_record = {}
    csv_record[:id] = workstation_status.id
    csv_record[:workstation_name] = workstation_status.workstation_name
    csv_record[:guest_flag] = workstation_status.guest_flag ? 't' : 'f'
    csv_record[:os] = workstation_status.os
    csv_record[:status] = workstation_status.status
    csv_record[:timestamp] = timestamp.strftime('%Y-%m-%d %H:%M:%S.%L')
    csv_record[:user_hash] = workstation_status.user_hash
    csv_record[:type] = workstation_status.workstation_type
    csv_record[:location] = workstation_status.location ? workstation_status.location.name : nil
    csv_record
  end

  # Writes the CSV record to the appropriate file, based on the timestamp
  def write_to_file(timestamp, csv_record)
    return if storage_dir == File::NULL

    filename = filename(timestamp)
    storage_path = Pathname.new(storage_dir).join(filename)

    create_file(storage_path, csv_record) unless storage_path.exist?
    write_row(storage_path, csv_record)
  end

  # Creates the CSV file, and adds the header row.
  def create_file(storage_path, csv_record)
    FileUtils.mkdir_p(storage_dir)

    CSV.open(storage_path, 'ab') do |csv|
      csv << csv_record.keys
    end
  end

  # Writes a single CSV row to an existing file.
  def write_row(storage_path, csv_record)
    CSV.open(storage_path, 'ab') do |csv|
      csv << csv_record.values
    end
  end

  # Returns the directory to write the CSV files to.
  def storage_dir
    Rails.configuration.x.history.storage_dir
  end

  # Returns the filename for the CSV file, basd on the given timestamp
  def filename(timestamp)
    base_filename = timestamp.in_time_zone.strftime('%Y-%m-%d')
    extension = 'csv'
    "#{base_filename}.#{extension}"
  end
end
