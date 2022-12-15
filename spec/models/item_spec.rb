require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @category = Category.create!(title: 'Electronics')
    @sub_category = SubCategory.create!(category: @category, title: 'Mobile-phones')
  end
    
  context "Item Creation" do
    it "Item is created successfull" do
    	@item = Item.create(category: @category, name: 'khoye wali kulfi', sub_category: @sub_category, price: 10)
    	expect(@item.valid?).to eq true
    end
  end

  context "#recalculate_current_quantity!" do
    before do
      @item = Item.create(category: @category, name: 'khoye wali kulfi', sub_category: @sub_category, price: 10)
    end

    it "calculates correctly for empty item" do
      @item.recalculate_current_quantity!
      expect(@item.quantity).to eq 0
    end

    it "updates quantity on adding asset" do
      LineItem.create!(quantity: 100, item_id: @item.id)
      @item.recalculate_current_quantity!

      expect(@item.quantity).to eq 100
    end
  end
end