# frozen_string_literal: true

class CheapoairFlightResultPage
  require_relative '../modules/utilities_modules'
  include PageObject
  include UtilitiesModules

  div(:result_header,class: 'filters--content col-12 p-0')
  link(:resul_popup,class:'modal-close')
  divs(:all_flight_price, class:'fare-details__fare')

  def get_flight_result_header
    result_header_element.when_present(45).text
    resul_popup_element.click if resul_popup_element.present?

  end

  def verify_flights_displayed?
    # @browser.wait_until(45) {result_header_element.exist}
    fail "Flight search results not found" unless result_header_element.when_present(45).text.include? 'results found'
  end
  def get_all_flights_price
    all_price = []
    all_flight_price_elements.each do |each_price|
      all_price << each_price.text.gsub('$','').to_i
    end

  end

end
