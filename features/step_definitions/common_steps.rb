When(/^I see the home page$/) do
  visit root_path
end

When(/^I click "([^"]*)"$/) do |link|
  click_on link
end

When(/^I click "([^"]*)" next to a (?:.*)$/) do |link|
  within("table tbody tr td:contains('#{link}')", match: :first) { click_on link }
end

When(/^I enter (.*) as (.*)$/) do |value, field|
  fill_in field, :with => value
end


Then(/^I should see a new (.*)$/) do |thing|
	expect(page).to have_content(/#{thing.capitalize} was successfully created./)
end

Then(/^I should see a (.*) destroyed$/) do |thing|
  expect(page).to have_content(/#{thing.capitalize} was successfully destroyed./)
end

Then(/^I should see "([^"]*)"$/) do |value|
  expect(page).to have_content(/#{value}/)
end
