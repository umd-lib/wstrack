# frozen_string_literal: true

xml.instruct!
xml.linkedHashMap do
  xml.availability("action"=>"list") do
    @availability_list.each do |item|
      xml.location("name" => item[:location_name], "key" => item[:location_code]) do
        xml.workstation("type" => "pc", "total" => item[:total_pc], "available" => item[:available_pc])
        xml.workstation("type" => "mac", "total" => item[:total_mac], "available" => item[:available_mac])
      end
    end
  end
end
