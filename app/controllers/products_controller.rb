class ProductsController < ApplicationController
  before_action :set_product, only: %i[update destroy]
  before_action :set_product_with_associations, only: %i[show edit]
  before_action :set_associations, only: %i[new edit]

  def index
    @products = Product
                .eager_load(:supplier, :category)
                .filter(filter_params)
                .order(:id)
    @categories = Category.all.order(:id)
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @product }
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(units_on_order: 0)
    @product.assign_attributes(permitted_attributes)

    if @product.save
      redirect_to product_path(@product)
    else
      redirect_to new_product_path
      flash[:error] = @product.errors.full_messages
    end
  end

  def edit; end

  def update
    @product.assign_attributes(permitted_attributes)

    if @product.save
      redirect_to product_path(@product)
    else
      redirect_to @product
      flash[:error] = @product.errors.full_messages
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path
    else
      flash[:error] = @product.errors.full_messages
    end
  end

  private

  def permitted_attributes
    params.require(:product).permit(
      :category_id,
      :supplier_id,
      :product_name,
      :quantity_per_unit,
      :unit_price,
      :units_in_stock,
      :reorder_level,
      :discountinued
    )
  end

  def filter_params
    @filter_params ||= params[:filter]&.slice(:product_name, :category_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_product_with_associations
    @product = Product.eager_load(:supplier, :category).find(params[:id])
  end

  def set_associations
    @suppliers = Supplier.order(:id).all
    @categories = Category.order(:id).all
  end
end
