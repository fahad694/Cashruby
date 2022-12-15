require 'rails_helper'

RSpec.describe User, type: :model do
  it "testing user model" do
    user = User.new(name: "fahad")
    binding.pry
    expect(user.name).to eq "fahad"
    binding.pry
  end
end
