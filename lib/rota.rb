require 'pry'
class Rota

  attr_reader :shifts

  MAX_NUMBER_OF_HOURS_PER_WEEK = 40

  def initialize(week_number: , shifts:)
    @week_number = week_number
    @shifts = shifts
  end

  class << self
    def book(**args)
      new(args).book
    end
  end

  def book
    return validate if validate.any?
    # I don't like this ^. It should say 'errors'

    'Shifts booked sucessfully'
  end

  private

  def validate
    errors = []

    shifts.each do |shift|
      errors << "#{shift.user.name}'s shift must be between 7am and 3am" if shift.not_within_opening_times?
    end

    shifts.each do |shift|
      errors << "#{shift.user.name}'s shift cannot be longer than 8 hours" if shift.longer_than_8_hours?
    end

    errors << errors_for_exeeding_max_hours_per_week if errors_for_exeeding_max_hours_per_week.any?

    # Doesn't quite work 👇
    # errors << "Shifts cannot overlap" if overlapping_shifts?

    errors.flatten
  end

  def errors_for_exeeding_max_hours_per_week
    # TODO: take week number or just a week into account
    errors = []
    employees = shifts.map(&:user).uniq

    shifts_durations_per_staff.each do |user, shifts_duration|
      errors << "#{user.name}'s shifts exeeds max number of hours" if shifts_duration > MAX_NUMBER_OF_HOURS_PER_WEEK
    end

    errors
  end

  def shifts_durations_per_staff
    employees = shifts.map(&:user).uniq

    employees.map do |employee|
      shift_duration = 0

      shifts.map do |shift|
        shift_duration += ((shift.end_date_time - shift.start_date_time) / 60 / 60 ) if shift.user == employee
      end

      [employee, shift_duration]
    end.to_h
  end

  def overlapping_shifts?
    return false if shifts.count < 2

    shifts.each do |shift_being_checked|
      shift_period = shift_being_checked.start_date_time..shift_being_checked.end_date_time
      shifts_to_compare = [shifts.delete(shift_being_checked)]

      shifts_to_compare.each do |shift|
        return true if (shift_period).overlaps?(shift.start_date_time..shift.end_date_time)
      end
    end

  end
end
