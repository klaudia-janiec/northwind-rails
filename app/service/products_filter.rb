class ProductsFilter
  def initialize(products, params)
    @products = products
    validate_params(params)
  end

  def apply
    @params.each do |key, value|
      @products = @products.public_send(key, value) if value.present?
    end
    @products
  end

  def validate_params(params)
    if params.is_a?(ActionController::Parameters)
      @params = params.slice(:product_name, :category_id)
    else
      @params = {}
    end
  end
end
