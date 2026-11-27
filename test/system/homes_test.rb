require "application_system_test_case"

class HomesTest < ApplicationSystemTestCase
  test "visiting the top page" do
    visit root_path

    assert_selector "h1", text: "Every Meow ^-^ Has a Story"
    assert_text "Share your cat's moments with us!"
  end

  test "navigating to the about page" do
    visit root_path

    click_link "About", exact: true

    assert_current_path about_path
  end
end
