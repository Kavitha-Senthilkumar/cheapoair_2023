Feature: Cheapoair Flight Search Functionality

#  Imperative Style
  Scenario: verify user is able to search for the available flights for a future date
    Given user is on the home page
    When user search for columbus city and selects CMH - Columbus ,ohio airport for departure
    And user search for Cleveland city and select CLE - Cleveland,ohio airport for arrival
    And user search for future date for departure
    And user search for future date for arrival
    And user search for available flights
    Then verify user should see the available flights

#    Declarative Style
  Scenario: verify user is able to search for the available flights for future date in Declarative style
    Given user is on the home page
    When user searches for the available flights for the future date
    Then verify user should see the available flights


#    Negative test cases


  Scenario: verify user is able to validate the mandatory search fields for all the flights for a future date
    Given user is on the home page
    When user leaves departure and arrival city field blank
#    And user search for future date for departure
#    And user search for future date for arrival
    And user search for available flights
    Then user should see the following error messages:
      | error_message                        |
      | Please enter a From city or airport. |
      | Please enter a To city or airport.   |


  Scenario Outline: verify user is able to search for available flights for a future dates for different location
    Given user is on the home page
    When user search for <dep_city_name> city and selects <dep_airport_name> airport for departure
    And user search for <arr_city_name> city and select <arr_airport_name> airport for arrival
    And user search for future date for departure
    And user search for future date for arrival
    And user search for available flights
    Then verify user should see the available flights
    Examples:
      | dep_city_name | dep_airport_name     | arr_city_name | arr_airport_name     |
      | Columbus      | CMH - Columbus ,ohio | Cleveland     | CLE - Cleveland,ohio |
      | Milwaukee     | MKE                  | Los Angeles   | LAX                  |

  Scenario: validate the flight search results are displayed with sort order of prices
    Given user is on the home page
    When user searches for the available flights for the future date
    Then verify user should see the available flights
    And flights search results are displayed with sort order of price
