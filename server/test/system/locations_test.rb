# frozen_string_literal: true

require 'application_system_test_case'

class LocationsTest < ApplicationSystemTestCase
  setup do
    @location = locations(:one)
    @unique_regex = "#{@location.regex}1"
  end

  test 'visiting the index' do
    visit locations_url
    assert_selector '.h1', text: 'Locations'
  end

  test 'creating a Location' do
    visit locations_url
    click_on 'New Location'

    fill_in 'Code', with: @location.code
    fill_in 'Regex', with: @unique_regex
    fill_in 'Name', with: @location.name
    click_on 'Create Location'

    assert_text 'Location was successfully created'
    click_on 'Back'
  end

  test 'updating a Location' do
    visit locations_url
    click_on 'Edit', match: :first

    fill_in 'Code', with: @location.code
    fill_in 'Regex', with: @unique_regex
    fill_in 'Name', with: @location.name
    click_on 'Update Location'

    assert_text 'Location was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Location' do
    visit locations_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Location was successfully destroyed'
  end
end