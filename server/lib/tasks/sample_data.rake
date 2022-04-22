namespace :db do
  desc 'Drop, create, migrate, seed and populate sample data'
  task reset_with_sample_data: [:drop, :create, :migrate, :seed, :populate_sample_data] do
    puts 'Ready to go!'
  end

  desc 'Populates the database with sample data'
  task populate_sample_data: :environment do
    require 'faker'

    # Suppress history CSV file output
    Rails.configuration.x.history.storage_dir = File::NULL

    Location.find_or_create_by(code: 'MCK1F', name: 'McKeldin Library 1st floor', regex: '(?i)^LIBRWKMCK[PM]1F.*$')
    Location.find_or_create_by(code: 'MCK2F', name: 'McKeldin Library 2nd floor', regex: '(?i)^LIBRWKMCK[PM]2F.*$')
    Location.find_or_create_by(code: 'MCK3F', name: 'McKeldin Library 3rd floor', regex: '(?i)^LIBRWKMCK[PM]3F.*$')
    Location.find_or_create_by(code: 'MCK4F', name: 'McKeldin Library 4th floor', regex: '(?i)^LIBRWKMCK[PM]4F.*$')
    Location.find_or_create_by(code: 'MCK5F', name: 'McKeldin Library 5th floor', regex: '(?i)^LIBRWKMCK[PM]5F.*$')
    Location.find_or_create_by(code: 'MCK6F', name: 'McKeldin Library 6th floor', regex: '(?i)^LIBRWKMCK[PM]6F[12]$')
    Location.find_or_create_by(code: 'MCK6F1', name: 'McKeldin Library 6th floor RM 6101', regex: '(?i)^LIBRWKMCK[PM]6FL.*$')
    Location.find_or_create_by(code: 'MCK6F3', name: 'McKeldin Library 6th floor RM 6103', regex: '(?i)^LIBRWKMCK[PM]6F3.*$')
    Location.find_or_create_by(code: 'MCK6F7', name: 'McKeldin Library 6th floor RM 6107', regex: '(?i)^LIBRWKMCK[PM]6F7.*$')
    Location.find_or_create_by(code: 'MCK7F', name: 'McKeldin Library 7th floor', regex: '(?i)^LIBRWKMCK[PM]7F.*$')
    Location.find_or_create_by(code: 'EPL1F', name: 'STEM Library 1st floor', regex: '(?i)^LIBRWKSTEM[PM]1F.*$')
    Location.find_or_create_by(code: 'EPL2F', name: 'STEM Library 2nd floor', regex: '(?i)^LIBRWKSTEM[PM]2F.*$')
    Location.find_or_create_by(code: 'EPL3F', name: 'STEM Library 3rd floor', regex: '(?i)^LIBRWKSTEM[PM]3F.*$')
    Location.find_or_create_by(code: 'CHM1F', name: 'Chemistry Library 1st floor', regex: '(?i)^LIBRWKCHM[PM]1F.*$')
    Location.find_or_create_by(code: 'CHM2F', name: 'Chemistry Library 2nd floor', regex: '(?i)^LIBRWKCHM[PM]2F.*$')
    Location.find_or_create_by(code: 'CHM3F', name: 'Chemistry Library 3rd floor', regex: '(?i)^LIBRWKCHM[PM]3F.*$')
    Location.find_or_create_by(code: 'LMSBF', name: 'Library Media Services Ground floor', regex: '(?i)^LIBRWKLMS[PM]BF.*$')
    Location.find_or_create_by(code: 'MDR1F', name: 'MARYLANDIA', regex: '(?i)^LIBRWKMDR[PM]1F.*$')
    Location.find_or_create_by(code: 'PAL1F', name: 'PAL 1st floor', regex: '(?i)^LIBRWKPAL[PM]1F.*$')
    Location.find_or_create_by(code: 'PAL2F', name: 'PAL 2nd floor', regex: '(?i)^LIBRWKPAL[PM]2F.*$')
    Location.find_or_create_by(code: 'ART1F', name: 'Art Library 1st floor', regex: '(?i)^LIBRWKART[PM]1F.*$')
    Location.find_or_create_by(code: 'ARC1F', name: 'Arch Library', regex: '(?i)^LIBRWKARC[PM]1F.*$')

    MAC_OS_LIST = ["Mac OS X 10.15.3", "Mac OS X 10.14.6", "Mac OS X 10.15.7"]
    STATUS_LIST = ["login", "logout"]

    num_status_per_location = 5
    last_created_at = nil
    Location.all.each do |location|
      location_processed = false
      catch :next_location do
        next if location_processed
        location_regexp = Regexp.new location.regex.sub('(?i)', '').sub('.*', '[0-9]{1,3}')
        generated_names = []
        num_status_per_location.times do |num|
          got_unique_name = false
          status = WorkstationStatus.new
          num_tries = 3
          while got_unique_name == false do
            throw :next_location unless num_tries > 0
            name = Faker::Base.regexify(location_regexp)
            unless generated_names.include?(name)
              status.workstation_name = name
              got_unique_name = true
              generated_names.push(name)
            end
            num_tries -= 1
          end
          status.os = status.workstation_name[10] == "P" ? "WINDOWS_NT" : MAC_OS_LIST.sample
          status.user_hash = Base64.encode64(Digest::MD5.digest(Faker::Internet.user_name(specifier: 8))).chomp
          status.status = STATUS_LIST.sample
          status.guest_flag = Faker::Boolean.boolean
          created_at = generate_created_at(num, num_status_per_location, last_created_at)
          updated_at = Faker::Time.between(from: created_at, to: Time.now)
          last_created_at = created_at
          status.created_at = created_at
          status.updated_at = updated_at
          status.save!
          location_processed = true
        end
      end
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