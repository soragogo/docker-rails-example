module Customer::ProductsHelper
    def category_active_class(category)
      params[:category].to_i == category ? 'bg-gray-300' : 'bg-gray-100'
    end
  end