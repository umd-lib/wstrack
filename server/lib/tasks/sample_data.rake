namespace :db do
  desc 'Drop, create, migrate, seed and populate sample data'
  task reset_with_sample_data: [:drop, :create, :migrate, :seed, :populate_sample_data] do
    puts 'Ready to go!'
  end

  desc 'Populates the database with sample data'
  task populate_sample_data: :environment do
    require 'faker'

    VALID_WORKSTATION_NAME_REGEX = /LIBRWK(MCK|LMS|ARC|ART|EPL|CHM|MDR|PAL)[PM][1-7B]F(1|3|7)?[0-9]{1,2}/
    MAC_OS_LIST = ["Mac OS X 10.15.3", "Mac OS X 10.14.6", "Mac OS X 10.15.7"]
    STATUS_LIST = ["login", "logout"]

    num_status = 50
    last_created_at = nil
    num_status.times do |num|
      status = WorkstationStatus.new
      status.workstation_name = Faker::Base.regexify(VALID_WORKSTATION_NAME_REGEX)
      puts status.workstation_name
      status.os = status.workstation_name[10] == "P" ? "WINDOWS_NT" : MAC_OS_LIST.sample
      status.user_hash = Base64.encode64(Digest::MD5.digest(Faker::Internet.user_name(specifier: 8)))
      status.status = STATUS_LIST.sample
      status.guest_flag = Faker::Boolean.boolean
      created_at = generate_created_at(num, num_status, last_created_at)
      updated_at = Faker::Time.between(from: created_at, to: Time.now)
      last_created_at = created_at
      status.created_at = created_at
      status.updated_at = updated_at
      status.save!
    end
  end

  # Generates "created_at" times over a range, to create a "nice" distribution
  # of times.
  #
  # current_index: The index of the current entry being generated
  # total_entries: The total number of entries that will be generated
  # last_created_at: The value of the last "created_at" entry, or nil
  def generate_created_at(current_index, total_entries, last_created_at)
    last_created_at = Time.new(2001, 1, 1, 0, 0, 0) if last_created_at.nil? # Midnight January 1, 2001
    now = Time.now
    difference_in_days = now - last_created_at
    percent = (current_index.to_f / total_entries) + 0.05
    latest_allowed_created_at = last_created_at + (difference_in_days * percent)
    latest_allowed_created_at = Time.now if latest_allowed_created_at > Time.now

    Faker::Time.between(from: last_created_at, to: latest_allowed_created_at)
  end
end