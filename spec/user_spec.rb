require 'user.rb'

RSpec.describe User do
  it 'initialises with a name' do
    user = User.new('John')

    expect(user.name).to eq('John')
  end
end
