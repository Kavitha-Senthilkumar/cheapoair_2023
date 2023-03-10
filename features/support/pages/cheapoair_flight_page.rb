# frozen_string_literal: true

class CheapoairFlightPage
  include PageObject
  page_url "www.cheapoair.com"
  text_field(:roundtrip, id: 'roundTrip')
  link(:suggestion_box, class: 'suggestion-box__clear icon', index: 0)
  text_field(:dep_airport_field, id: 'from0')
  unordered_list(:all_suggested_airport, class: 'suggestion-box__list autoSuggest__list')
  link(:sugesstion_box1, class: 'suggestion-box__clear icon', index: 1)
  text_field(:arr_airport_field, id: 'to0')
  unordered_list(:all_arr_suggested_airport, class: 'suggestion-box__list autoSuggest__list', index: 1)
  div(:dep_date, class: 'col-6 calendarDepart')
  div(:arr_date, class: 'col-6 calendarReturn')
  button(:search_flight,id: 'searchNow')
  list_items(:all_error,class:'alerts__item')


  def select_roundtrip
    roundtrip_element.click
  end

  def search_dep_airport dep_city, dep_airport
    # clear_dep_search = @browser.link(class: 'suggestion-box__clear icon', index: 0)
    # @browser.link(class:'suggestion-box__clear icon' , index:0).click if @browser.link(class:'suggestion-box__clear icon' , index:0).present?
    suggestion_box_element.click if suggestion_box_element.present?
    dep_airport_field_element.send_keys dep_city
    # only for edit box
    # self.dep_airport_field = dep_city

    sleep 2
    all_suggested_airport_element.lis.each do |each_airport|
      p each_airport.text
      if each_airport.text.include? dep_airport
        each_airport.click
        break
      end
    end
  end

  # @browser.text_field(id:'roundTrip').click
  def search_arr_airport arr_city, arr_airport
    sugesstion_box1_element.click if sugesstion_box1_element.present?
    arr_airport_field_element.send_keys arr_city
    sleep 2
    all_arr_suggested_airport_element.lis.each do |each_airport|

      p each_airport.text
      if each_airport.text.include? arr_airport

        each_airport.click
        break
      end
    end
  end

  def cal_date no_of_days
    (Time.now + 24 * 60 * 60 * no_of_days).strftime("%-d %B %Y")

  end

  def choose_dep_date no_of_days
    exact_date = cal_date no_of_days
    p exact_date
    dep_date_element.click
    # @browser.text_field(id: 'cal0').click
    @browser.link(aria_label: exact_date).click
  end

  def choose_arr_date no_of_days
    exact_date = cal_date no_of_days
    p exact_date
    arr_date_element.click
    @browser.link(aria_label: exact_date).click
  end
  def search_available_flight dep_city,dep_airport,arr_city,arr_airport
    search_dep_airport dep_city, dep_airport
    search_arr_airport arr_city, arr_airport
    choose_dep_date 2
    choose_arr_date 8
    search_flight_element.click
  end

  def get_all_error
    all_error_elements.map(&:text)
  #   expexp_arr = ['Please enter a From city or airport.','Please enter a To city or airport.']
  # actual_arr = @browser.lis(class:'alerts__item').map(&:text)
  # fail "Test case fail " if actual_arr != exp_arr
  end
end
