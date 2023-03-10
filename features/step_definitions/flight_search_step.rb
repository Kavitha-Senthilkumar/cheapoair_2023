Given(/^user is on the home page$/) do
  visit CheapoairFlightPage
end

When(/^user select Round Trip$/) do
  on(CheapoairFlightPage).select_roundtrip
end

And(/^user search for (.*) city and selects (.*) airport for departure$/) do |dep_city, dep_airport|
  on(CheapoairFlightPage).search_dep_airport dep_city, dep_airport
end

And(/^user search for (.*) city and select (.*) airport for arrival$/) do |arr_city, arr_airport|
  on(CheapoairFlightPage).search_arr_airport arr_city, arr_airport

end

And(/^user search for future date for departure$/) do
  on(CheapoairFlightPage).choose_dep_date 2
end

And(/^user search for future date for arrival$/) do
  on(CheapoairFlightPage).choose_arr_date 5
end

And(/^user search for available flights$/) do
  on(CheapoairFlightPage).search_flight_element.click
end

Then(/^verify user should see the available flights$/) do
  # on(CheapoairFlightResultPage).verify_flights_displayed?
  actual_value = on(CheapoairFlightResultPage).get_flight_result_header
  sleep 1
  on(CheapoairFlightResultPage).verify_expected_value_exits? actual_value , 'results found'


#   rspec method
#   expect(actual_value).should include 'result found'


end

When(/^user searches for the available flights for the future date$/) do
  on(CheapoairFlightPage).search_available_flight "Columbus","CMH - Columbus ,ohio","Cleveland ","CLE - Cleveland,ohio"
end

When(/^user leaves departure and arrival city field blank$/) do
  on(CheapoairFlightPage).suggestion_box_element.click if on(CheapoairFlightPage).suggestion_box_element.present?
  on(CheapoairFlightPage).sugesstion_box1_element.click if on(CheapoairFlightPage).sugesstion_box1_element.present?
end

Then(/^user should see the following error messages:$/) do |table|
  all_error_message= on(CheapoairFlightPage).get_all_error
  table.hashes.each do|each_error|
    current_error= each_error ['error_message']
    fail "#{current_error} is NOT found in all the Errors #{all_error_message}" unless all_error_message.include? each_error ['error_message']
  end
end

And(/^flights search results are displayed with sort order of price$/) do
  all_price = on.(CheapoairFlightResultPage).get_all_flights_price
  fail "all_price not sorted" unless all_price == all_price.sort
end