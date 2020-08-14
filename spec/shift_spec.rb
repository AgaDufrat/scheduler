require 'shift.rb'

RSpec.describe Shift do
  let(:user) { User.new('John') }

  it 'initializes with user, start_date_time and end_date_time' do
    # Timecop.freeze(Time.local(2020, 1, 1, 8, 0, 0)) do
      start_time = Time.new(2020, 1, 2, 8, 0, 0)
      end_time =  Time.new(2020, 1, 2, 10, 0, 0)
      shift = Shift.new(
        user: user,
        start_date_time: start_time,
        end_date_time: end_time,
      )

      expect(shift.user).to eq(user)
      expect(shift.start_date_time).to eq(start_time)
      expect(shift.end_date_time).to eq(end_time)
    # end
  end

  # Shoreditch House is open from 7am until 3am, 7 days a week
  describe "#not_within_opening_times?" do
    it 'return an false when the shift is within opening hours' do
      start_time = Time.new(2020, 1, 2, 8, 0, 0)
      end_time =  Time.new(2020, 1, 2, 10, 0, 0)
      shift = Shift.new(
        user: user,
        start_date_time: start_time,
        end_date_time: end_time,
      )

      expect(shift.not_within_opening_times?).to eq(false)
    end

    it 'return an true when the start time is before 7am' do
      start_time = Time.new(2020, 1, 2, 7, 0, 0)
      end_time =  Time.new(2020, 1, 2, 10, 0, 0)
      shift = Shift.new(
        user: user,
        start_date_time: start_time,
        end_date_time: end_time,
      )

      expect(shift.not_within_opening_times?).to eq(true)
    end

    it 'return an true when the end time is after 3am' do
      start_time = Time.new(2020, 1, 2, 2, 0, 0)
      end_time =  Time.new(2020, 1, 2, 4, 0, 0)
      shift = Shift.new(
        user: user,
        start_date_time: start_time,
        end_date_time: end_time,
      )

      expect(shift.not_within_opening_times?).to eq(true)
    end
  end

  # Shifts can be a maximum of 8 hours long
  describe "#longer_than_8_hours?" do
    it 'return an true if the shift is longer than 8 hours' do
      start_time = Time.new(2020, 1, 2, 8, 0, 0)
      end_time =  Time.new(2020, 1, 2, 20, 0, 0)
      shift = Shift.new(
        user: user,
        start_date_time: start_time,
        end_date_time: end_time,
      )

      expect(shift.longer_than_8_hours?).to eq(true)
    end

    it 'return an false if the shift is longer than 8 hours' do
      start_time = Time.new(2020, 1, 2, 8, 0, 0)
      end_time =  Time.new(2020, 1, 2, 16, 0, 0)
      shift = Shift.new(
        user: user,
        start_date_time: start_time,
        end_date_time: end_time,
      )

      expect(shift.longer_than_8_hours?).to eq(false)
    end
  end
end
