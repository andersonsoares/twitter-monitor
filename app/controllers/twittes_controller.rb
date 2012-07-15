class TwittesController < ApplicationController
  # GET /twittes
  # GET /twittes.json
  def index
    @twittes = Twitte.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @twittes }
    end
  end

  # GET /twittes/1
  # GET /twittes/1.json
  def show
    @twitte = Twitte.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @twitte }
    end
  end

  # GET /twittes/new
  # GET /twittes/new.json
  def new
    @twitte = Twitte.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @twitte }
    end
  end

  # GET /twittes/1/edit
  def edit
    @twitte = Twitte.find(params[:id])
  end

  # POST /twittes
  # POST /twittes.json
  def create
    @twitte = Twitte.new(params[:twitte])

    respond_to do |format|
      if @twitte.save
        format.html { redirect_to @twitte, notice: 'Twitte was successfully created.' }
        format.json { render json: @twitte, status: :created, location: @twitte }
      else
        format.html { render action: "new" }
        format.json { render json: @twitte.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /twittes/1
  # PUT /twittes/1.json
  def update
    @twitte = Twitte.find(params[:id])

    respond_to do |format|
      if @twitte.update_attributes(params[:twitte])
        format.html { redirect_to @twitte, notice: 'Twitte was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @twitte.errors, status: :unprocessable_entity }
      end
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
