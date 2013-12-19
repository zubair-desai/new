Given(/^a user visits the edit page$/) do
   visit edit_user_path(user) 
end

When(/^they enter valid information$/) do
  let(:user) { FactoryGirl.create(:user)}
end

When(/^they click Save changes$/) do
   click_button "Save changes"
end

Then(/^they should see a success message$/) do
  expect(page).to have_selector('div.alert.alert-success')
end

When(/^they click Save changes$/) do
   click_button "Save changes"
end


Then(/^they should see a success message$/) do
  expect(page).to have_selector('div.alert.alert-error')
end

