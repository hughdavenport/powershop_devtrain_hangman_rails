When(/^I see the home page$/) do
  visit root_path
end

When(/^I click "([^"]*)"$/) do |link|
  click_on link
end

Then(/^I should see a new game$/) do
	expect(page).to have_content(/Game was successfully created./)
end
