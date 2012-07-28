class KeywordsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  load_and_authorize_resource except: [:index]
  
  # GET /keywords
  # GET /keywords.json
  def index
    @keywords = Keyword.order("name desc").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @keywords }
    end
  end

  # GET /keywords/1
  # GET /keywords/1.json
  def show
    @keyword = Keyword.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @keyword }
    end
  end

  # GET /keywords/new
  # GET /keywords/new.json
  def new
    @keyword = Keyword.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @keyword }
    end
  end

 

  # POST /keywords
  # POST /keywords.json
  def create
    @keyword = Keyword.new(params[:keyword])
    @keyword.user = current_user

    respond_to do |format|
      if @keyword.save
        
        #recovery twittes
        #@keyword.recover_all_twittes
        RecoverTwittesWorker.perform_async(@keyword.id,@keyword.name)
        
        format.html { redirect_to keywords_url, notice: 'Keyword was successfully created.' }
        format.json { render json: @keyword, status: :created, location: @keyword }
      else
        format.html { render action: "new" }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # # GET /keywords/1/edit
  #    def edit
  #      @keyword = Keyword.find(params[:id])
  #    end
  # 
  # 
  #   # PUT /keywords/1
  #   # PUT /keywords/1.json
  #   def update
  #     @keyword = Keyword.find(params[:id])
  # 
  #     respond_to do |format|
  #       if @keyword.update_attributes(params[:keyword])
  #         format.html { redirect_to @keyword, notice: 'Keyword was successfully updated.' }
  #         format.json { head :no_content }
  #       else
  #         format.html { render action: "edit" }
  #         format.json { render json: @keyword.errors, status: :unprocessable_entity }
  #       end
  #     end
  #   end
  # 
    # DELETE /keywords/1
    # DELETE /keywords/1.json
    def destroy
      @keyword = Keyword.find(params[:id])
      @keyword.destroy
  
      respond_to do |format|
        format.html { redirect_to keywords_url, notice: 'Keyword was successfully removed.' }
        format.json { head :no_content }
      end
    end
end
