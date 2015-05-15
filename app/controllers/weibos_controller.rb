class WeibosController < ApplicationController
  before_action :set_weibo, only: [:show, :edit, :update, :destroy]

  # GET /weibos
  # GET /weibos.json
  def index
    @weibos = Weibo.all
  end

  # GET /weibos/1
  # GET /weibos/1.json
  def show
  end

  # GET /weibos/new
  def new
    @weibo = Weibo.new
  end

  # GET /weibos/1/edit
  def edit
  end

  # POST /weibos
  # POST /weibos.json
  def create
    @weibo = Weibo.new(weibo_params)

    respond_to do |format|
      if @weibo.save
        format.html { redirect_to @weibo, notice: 'Weibo was successfully created.' }
        format.json { render :show, status: :created, location: @weibo }
      else
        format.html { render :new }
        format.json { render json: @weibo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weibos/1
  # PATCH/PUT /weibos/1.json
  def update
    respond_to do |format|
      if @weibo.update(weibo_params)
        format.html { redirect_to @weibo, notice: 'Weibo was successfully updated.' }
        format.json { render :show, status: :ok, location: @weibo }
      else
        format.html { render :edit }
        format.json { render json: @weibo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weibos/1
  # DELETE /weibos/1.json
  def destroy
    @weibo.destroy
    respond_to do |format|
      format.html { redirect_to weibos_url, notice: 'Weibo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weibo
      @weibo = Weibo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weibo_params
      params.require(:weibo).permit(:content, :user_id)
    end
end
