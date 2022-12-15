require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @category = Category.create!(title: 'Tech')
    @sub_category = SubCategory.create!(category: @category, title: 'SmartPhones')
    @item = Item.create!(category: @category, sub_category: @sub_category, name: 'OnePlus 7pro', price: 10)
  end

  it "testing user model" do
    user = User.new(name: "fahad")
    expect(user.name).to eq "fahad"
  end

  it "testing user model" do
    user = User.new(email: "test@email.com")
    expect(user.email).to eq "test@email.com"
  end
end
