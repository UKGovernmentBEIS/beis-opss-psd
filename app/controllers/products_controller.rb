class ProductsController < ApplicationController
  include CountriesHelper
  include ProductsHelper
  include UrlHelper
  helper_method :sort_column, :sort_direction

  before_action :set_search_params, only: %i[index]
  before_action :set_product, only: %i[show edit update]
  before_action :set_countries, only: %i[update edit]
  before_action :build_breadcrumbs, only: %i[show]

  # GET /products
  # GET /products.json
  def index
    respond_to do |format|
      format.html do
        @products = search_for_products(Product.count, [:investigations, :test_results, corrective_actions: [:business], risk_assessments: [:assessed_by_business, :assessed_by_team]]).sort
        @product_export = ProductExport.create
        @product_export.export(@products)
      end
      format.xlsx do
        authorize Product, :export?

        @products = search_for_products(Product.count, [:investigations, :test_results, corrective_actions: [:business], risk_assessments: [:assessed_by_business, :assessed_by_team]]).sort
        # product_export.export_file.attach(export_file)
        # byebug
      end
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /products/1/edit
  def edit
    @product_form = ProductForm.from(Product.find(params[:id]))
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      product = Product.find(params[:id])
      @product_form = ProductForm.from(product)
      @product_form.attributes = product_params

      if @product_form.valid?
        format.html do
          UpdateProduct.call!(
            product: product,
            product_params: @product_form.serializable_hash
          )

          redirect_to product_path(product), flash: { success: "Product was successfully updated." }
        end
        format.json { render :show, status: :ok, location: product }
      else
        format.html { render :edit }
        format.json { render json: product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy!
    respond_to do |format|
      format.html { redirect_to products_path, flash: { success: "Product was successfully deleted." } }
      format.json { head :no_content }
    end
  end

  def filter_params
    if params["hazard_type"].present?
      { must: [{ match: { "investigations.hazard_type" => @search.hazard_type } }] }
    end
  end

private

  def build_breadcrumbs
    @breadcrumbs = build_back_link_to_case || build_breadcrumb_structure
  end
end
