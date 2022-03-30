require "application_system_test_case"

class WorkstationStatusesTest < ApplicationSystemTestCase
  setup do
    @workstation_status = workstation_statuses(:one)
  end

  test "visiting the index" do
    visit workstation_statuses_url
    assert_selector "h1", text: "Workstation Statuses"
  end

  test "creating a Workstation status" do
    visit workstation_statuses_url
    click_on "New Workstation Status"

    check "Guest flag" if @workstation_status.guest_flag
    fill_in "Os", with: @workstation_status.os
    fill_in "Status", with: @workstation_status.status
    fill_in "User hash", with: @workstation_status.user_hash
    fill_in "Workstation name", with: @workstation_status.workstation_name
    fill_in "Workstation type", with: @workstation_status.workstation_type
    click_on "Create Workstation status"

    assert_text "Workstation status was successfully created"
    click_on "Back"
  end

  test "updating a Workstation status" do
    visit workstation_statuses_url
    click_on "Edit", match: :first

    check "Guest flag" if @workstation_status.guest_flag
    fill_in "Os", with: @workstation_status.os
    fill_in "Status", with: @workstation_status.status
    fill_in "User hash", with: @workstation_status.user_hash
    fill_in "Workstation name", with: @workstation_status.workstation_name
    fill_in "Workstation type", with: @workstation_status.workstation_type
    click_on "Update Workstation status"

    assert_text "Workstation status was successfully updated"
    click_on "Back"
  end

  test "destroying a Workstation status" do
    visit workstation_statuses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Workstation status was successfully destroyed"
  end
end
