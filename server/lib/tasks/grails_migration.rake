namespace :db do
  desc 'Imports current workstation status from CSV file'
  task clear_current_workstation_status: :environment do
    WorkstationStatus.destroy_all
  end

  task :import_current_workstation_status, %i[csv_file] => :environment do |_t, args|
    require 'csv'

    csv_file = args[:csv_file]

    errors_occurred = false

    records_imported = 0
    CSV.parse(File.read(csv_file), headers:true) do |row|
      workstation_status = WorkstationStatus.new
      workstation_status.workstation_name = row['computer_name']
      workstation_status.guest_flag = row['guest_flag']
      workstation_status.os = row['os']
      workstation_status.status = row['status']
      workstation_status.user_hash = row['user_hash']
      workstation_status.updated_at = 2.days.ago

      timestamp =Time.parse(row['timestamp'])
      workstation_status.updated_at = timestamp
      workstation_status.save!
      records_imported += 1
    rescue StandardError => e
      puts "Error while processing row=#{row}"
      puts "Error: #{e}"
      errors_occurred = true
    end

    puts "Imported #{records_imported} records."

    if errors_occurred
      puts "FAILURE. Errors occurred."
    else
      puts "SUCCESS"
    end
  end
end
