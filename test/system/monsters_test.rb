require "application_system_test_case"

class MonstersTest < ApplicationSystemTestCase
  setup do
    @monster = monsters(:one)
  end

  test "visiting the index" do
    visit monsters_url
    assert_selector "h1", text: "Monsters"
  end

  test "creating a Monster" do
    visit monsters_url
    click_on "New Monster"

    click_on "Create Monster"

    assert_text "Monster was successfully created"
    click_on "Back"
  end

  test "updating a Monster" do
    visit monsters_url
    click_on "Edit", match: :first

    click_on "Update Monster"

    assert_text "Monster was successfully updated"
    click_on "Back"
  end

  test "destroying a Monster" do
    visit monsters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Monster was successfully destroyed"
  end
end
