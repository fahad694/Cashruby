module ApplicationHelper
  def sub_category_options(sub_categories)
    options_for_select(@sub_categories.map do |sub_category|
      [sub_category.title, sub_category.id]
    end)
  end
end
