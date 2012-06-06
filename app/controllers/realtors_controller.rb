class RealtorsController < ApplicationController
  # GET /realtors
  # GET /realtors.json
  def index
    @realtors = Realtor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @realtors }
    end
  end

  # GET /realtors/1
  # GET /realtors/1.json
  def show
    @realtor = Realtor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @realtor }
    end
  end

  # GET /realtors/new
  # GET /realtors/new.json
  def new
    @realtor = Realtor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @realtor }
    end
  end

  # GET /realtors/1/edit
  def edit
    @realtor = Realtor.find(params[:id])
  end

  # POST /realtors
  # POST /realtors.json
  def create
    @realtor = Realtor.new(params[:realtor])

    respond_to do |format|
      if @realtor.save
        format.html { redirect_to @realtor, notice: 'Realtor was successfully created.' }
        format.json { render json: @realtor, status: :created, location: @realtor }
      else
        format.html { render action: "new" }
        format.json { render json: @realtor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /realtors/1
  # PUT /realtors/1.json
  def update
    @realtor = Realtor.find(params[:id])

    respond_to do |format|
      if @realtor.update_attributes(params[:realtor])
        format.html { redirect_to @realtor, notice: 'Realtor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @realtor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /realtors/1
  # DELETE /realtors/1.json
  def destroy
    @realtor = Realtor.find(params[:id])
    @realtor.destroy

    respond_to do |format|
      format.html { redirect_to realtors_url }
      format.json { head :no_content }
    end
  end
end
