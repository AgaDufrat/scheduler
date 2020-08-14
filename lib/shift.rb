require 'date'
require 'active_support/all'

class Shift
  attr_reader :user, :start_date_time, :end_date_time

  OFFICE_OPENING_TIME = 7
  OFFICE_CLOSING_TIME = 3
  MAX_NUMBER_OF_HOURS = 8

  def initialize(user: , start_date_time:, end_date_time: )
    @user = user
    @start_date_time = start_date_time
    @end_date_time = end_date_time
  end

  def not_within_opening_times?
    (start_date_time.beginning_of_hour.hour >= OFFICE_CLOSING_TIME && end_date_time.beginning_of_hour.hour < OFFICE_OPENING_TIME) ||
      (end_date_time.beginning_of_hour.hour > OFFICE_CLOSING_TIME && start_date_time.beginning_of_hour.hour <= OFFICE_OPENING_TIME)
  end

  def longer_than_8_hours?
    ((end_date_time - start_date_time) / 60 / 60 ) > MAX_NUMBER_OF_HOURS
  end
end
