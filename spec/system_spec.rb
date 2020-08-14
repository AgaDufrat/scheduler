# require 'user.rb'
# require 'shift.rb'
# require 'rota.rb'
#
# RSpec.describe Rota do
#   fcontext "User books valid shifts" do
#     it 'return success message' do
#       user1 = User.new('John')
#       user2 = User.new('Bob')
#
#       shift1 = Shift.new(
#         user: user1,
#         start_date_time: Time.new(2020, 1, 2, 8, 0, 0),
#         end_date_time: Time.new(2020, 1, 2, 10, 0, 0),
#       )
#       shift2 = Shift.new(
#         user: user2,
#         start_date_time: Time.new(2020, 1, 3, 8, 0, 0),
#         end_date_time: Time.new(2020, 1, 3, 10, 0, 0),
#       )
#
#       rota = Rota(
#         week_number: 1,
#         shifts: [shift1, shift2]
#       )
#
#       expect(rota.book).to eq('Shifts booked sucessfully')
#     end
#   end
# end
