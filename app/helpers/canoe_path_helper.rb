module CanoePathHelper
    def path_with_category(category, options = {})
    options.update(category_id: category.id)
    canoe_category_path(category.canoe, options)
  end
end
