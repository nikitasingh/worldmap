class ColleaguesController < ApplicationController
  # GET /colleagues
  # GET /colleagues.json
  def index
    @colleagues = Colleague.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @colleagues }
    end

  end

  # GET /colleagues/1
  # GET /colleagues/1.json
  def show
    @colleague = Colleague.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @colleague }
    end
  end

  # GET /colleagues/new
  # GET /colleagues/new.json
  def new
    @colleague = Colleague.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @colleague }
    end
  end

  # GET /colleagues/1/edit
  def edit
    @colleague = Colleague.find(params[:id])
  end

  # POST /colleagues
  # POST /colleagues.json
  def create
    @colleague = Colleague.new(params[:colleague])

    respond_to do |format|
      if @colleague.save
        format.html { redirect_to @colleague, notice: 'Colleague was successfully created.' }
        format.json { render json: @colleague, status: :created, location: @colleague }
      else
        format.html { render action: "new" }
        format.json { render json: @colleague.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /colleagues/1
  # PUT /colleagues/1.json
  def update
    @colleague = Colleague.find(params[:id])

    respond_to do |format|
      if @colleague.update_attributes(params[:colleague])
        format.html { redirect_to @colleague, notice: 'Colleague was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @colleague.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colleagues/1
  # DELETE /colleagues/1.json
  def destroy
    @colleague = Colleague.find(params[:id])
    @colleague.destroy

    respond_to do |format|
      format.html { redirect_to colleagues_url }
      format.json { head :no_content }
    end
  end


  def map
    @countmum=Colleague.where(:location=> "mumbai").count
  

  end

  def list
    
  

  end

def search
  name=params[:search]
  
  @users=Colleague.where(:name=>name)#.select(:location)
  @users.each do |user| 
    @name=user.name
  @location=user.location
  render :inline => @location
end
 
end

def searchinloc
  name=params[:search]
  loc=params[:loc]
  @users=Colleague.where(:name=>name,:location=>loc)
   @users.each do |user| 
    @name=user.name
  @location=user.location
  render :inline=>"" 
end
end

def allpins
 @collegues=Colleague.select("DISTINCT location,project")
 @location="["
@place='"place":'
@project='"project":'
@start="{"
@end="}"
  @collegues.each do |colleague|

    @location= @location+ @start+ @place + '"'+colleague.location+'",'+
    @project+'"'+colleague.project+'"'+@end+","
end
@location = @location[0..@location.length-2]
@location = @location +"]"
p "^^^^^^^^^^^^^^^^"
p @location
render :inline =>@location
end


end
