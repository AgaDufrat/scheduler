require 'user.rb'
require 'shift.rb'
require 'rota.rb'

RSpec.describe Rota do
  let(:user1) { User.new('John') }
  let(:user2) { User.new('Bob') }

  context "User books valid shifts" do
    it 'return success message' do
      shift1 = Shift.new(
        user: user1,
        start_date_time: Time.new(2020, 1, 2, 8, 0, 0),
        end_date_time: Time.new(2020, 1, 2, 10, 0, 0),
      )
      shift2 = Shift.new(
        user: user2,
        start_date_time: Time.new(2020, 1, 10, 8, 0, 0),
        end_date_time: Time.new(2020, 1, 10, 10, 0, 0),
      )

      expect(Rota.book(week_number: 1, shifts: [shift1, shift2])).to eq('Shifts booked sucessfully')
    end
  end

  context "User books a shift not within opening times" do
    it 'return an error message' do
      shift1 = Shift.new(
        user: user1,
        start_date_time: Time.new(2020, 1, 2, 7, 0, 0),
        end_date_time: Time.new(2020, 1, 2, 10, 0, 0),
      )

      expect(Rota.book(week_number: 1, shifts: [shift1])).to eq(["John's shift must be between 7am and 3am"])
    end

    it 'return an error message' do
      shift1 = Shift.new(
        user: user1,
        start_date_time: Time.new(2020, 1, 2, 1, 0, 0),
        end_date_time: Time.new(2020, 1, 2, 4, 0, 0),
      )

      expect(Rota.book(week_number: 1, shifts: [shift1])).to eq(["John's shift must be between 7am and 3am"])
    end
  end

  context "User books a shift longer than 8 hours" do
    it 'return an error message' do
      shift1 = Shift.new(
        user: user1,
        start_date_time: Time.new(2020, 1, 2, 8, 0, 0),
        end_date_time: Time.new(2020, 1, 2, 20, 0, 0),
      )

      expect(Rota.book(week_number: 1, shifts: [shift1])).to eq(["John's shift cannot be longer than 8 hours"])
    end
  end

  context "User books shifs that exceed 40 hours per week" do
    it 'return an error message' do
      shift1 = Shift.new(
        user: user1,
        start_date_time: Time.new(2020, 1, 2, 8, 0, 0),
        end_date_time: Time.new(2020, 1, 2, 15, 0, 0),
      )
      shift2 = Shift.new(
        user: user1,
        start_date_time: Time.new(2020, 1, 3, 8, 0, 0),
        end_date_time: Time.new(2020, 1, 3, 15, 0, 0),
      )
      shift3 = Shift.new(
        user: user1,
        start_date_time: Time.new(2020, 1, 4, 8, 0, 0),
        end_date_time: Time.new(2020, 1, 4, 15, 0, 0),
      )
      shift4 = Shift.new(
        user: user1,
        start_date_time: Time.new(2020, 1, 5, 8, 0, 0),
        end_date_time: Time.new(2020, 1, 5, 15, 0, 0),
      )
      shift5 = Shift.new(
        user: user1,
        start_date_time: Time.new(2020, 1, 6, 8, 0, 0),
        end_date_time: Time.new(2020, 1, 6, 15, 0, 0),
      )
      shift6 = Shift.new(
        user: user1,
        start_date_time: Time.new(2020, 1, 7, 8, 0, 0),
        end_date_time: Time.new(2020, 1, 7, 15, 0, 0),
      )

      shift0 = Shift.new(
        user: user2,
        start_date_time: Time.new(2020, 1, 8, 8, 0, 0),
        end_date_time: Time.new(2020, 1, 8, 15, 0, 0),
      )

      expect(Rota.book(
        week_number: 1,
        shifts: [shift0, shift1, shift2, shift3, shift4, shift5, shift6])).to eq(["John's shifts exeeds max number of hours"])
    end
  end

  xcontext "More than one staff tries to book the same shift" do
    it 'return an error message' do
      shift1 = Shift.new(
        user: user1,
        start_date_time: Time.new(2020, 1, 2, 8, 0, 0),
        end_date_time: Time.new(2020, 1, 2, 15, 0, 0),
      )
      shift2 = Shift.new(
        user: user2,
        start_date_time: Time.new(2020, 1, 2, 8, 0, 0),
        end_date_time: Time.new(2020, 1, 2, 15, 0, 0),
      )
      shift3 = Shift.new(
        user: user2,
        start_date_time: Time.new(2020, 1, 3, 8, 0, 0),
        end_date_time: Time.new(2020, 1, 3, 15, 0, 0),
      )

      expect(Rota.book(week_number: 1, shifts: [shift1, shift2, shift3])).to eq(["Shifts cannot overlap"])
    end
  end
end
