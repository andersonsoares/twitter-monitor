class TwittesController < ApplicationController
  # GET /twittes
  # GET /twittes.json
  def index
    
    @keyword = Keyword.find(params[:keyword_id])
    
    @twittes = Twitte.where(:keyword_id=>@keyword.id).order("date desc").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @twittes }
    end
  end

  # DELETE /twittes/1
  # DELETE /twittes/1.json
  def destroy
    @twitte = Twitte.find(params[:id])
    @twitte.destroy

    respond_to do |format|
      format.html { redirect_to twittes_url }
      format.json { head :no_content }
    end
  end
end
