class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :delete_images, only:[:destroy]
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        if params[:product_images]
          params[:product_images].each do |image|
            @product.product_images.create(image: image)
          end
        end
        format.html { redirect_to @product, notice: 'Товар успешно добавлен.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        if params[:product_images]
          @product.product_images.each {|i| i.delete_with_file}
          params[:product_images].each do |image|
            @product.product_images.create(image: image)
          end
        end
        format.html { redirect_to @product, notice: 'Товар упешно обновлен.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Товар удален.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def delete_images
      begin
        @product.product_images.each do |p_i|
          File.delete(p_i.image.options[:path]+p_i.image_file_name)
        end
      rescue
        logger.debug 'Не удалось удалить изображение'
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:product_type,  :quantity, :price, :b_size, :b_material)
    end
end




