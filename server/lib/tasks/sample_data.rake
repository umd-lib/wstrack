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