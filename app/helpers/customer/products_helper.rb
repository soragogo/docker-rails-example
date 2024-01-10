module Customer::ProductsHelper
    def category_active_class(category)
      params[:category].to_i == category ? "bg-gray-800 text-gray-100" : "bg-gray-100 text-gray-800"
    end
  end