require "application_system_test_case"

class ScpsTest < ApplicationSystemTestCase
  setup do
    @scp = scps(:one)
  end

  test "visiting the index" do
    visit scps_url
    assert_selector "h1", text: "Scps"
  end

  test "creating a Scp" do
    visit scps_url
    click_on "New Scp"

    click_on "Create Scp"

    assert_text "Scp was successfully created"
    click_on "Back"
  end

  test "updating a Scp" do
    visit scps_url
    click_on "Edit", match: :first

    click_on "Update Scp"

    assert_text "Scp was successfully updated"
    click_on "Back"
  end

  test "destroying a Scp" do
    visit scps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Scp was successfully destroyed"
  end
end
