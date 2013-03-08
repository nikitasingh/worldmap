class ColleaguesController < ApplicationController
  # GET /colleagues
  # GET /colleagues.json
  def index
    @colleagues= Colleague.page(params[:page]).per(5).order("id asc")
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
    p @colleague.location
    res = Geokit::Geocoders::GoogleGeocoder.geocode(@colleague.location).ll

    latlong= res.split(",")

    p "********************##############**********}"
    p latlong.blank?
    p latlong

    p "********************##############**********}"





    @colleague.latitude=latlong[1]
    @colleague.longitude=latlong[0]

    respond_to do |format|
      if !(latlong.blank?)
        if @colleague.save 
          format.html { redirect_to colleagues_path, notice: 'Colleague was successfully created.' }
          format.json { render json: @colleague, status: :created, location: @colleague }
        else
          format.html { render action: "new" }
          format.json { render json: @colleague.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to new_colleague_path, notice: 'Invalid Location ..!!' }
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
def locationlist
loc=params[:loc]

  

 @collegues= @users=Colleague.where(:location=>loc)
p @colleagues


 @location="["
 @place='"cname":'
 @image='"image":'
 @start="{"
 @end="}"
 @collegues.each do |colleague|

  @location= @location+ @start+ 
  @place + '"'+colleague.name+'",'+
  @image+'"..'+colleague.attachment.url(:small)+'"' +
 
  @end+","



end
@location = @location[0..@location.length-2]
@location = @location +"]"
p "^^^^^^^^^^^^^^^^"
p @location

render :inline =>@location

end

  def autocomplete

    p "inside autocomplete"

    @colleagues=Colleague.all
    @list="["
    @name='"name":'

    @start="{"
    @end="}"
    @colleagues.each do |colleague|

      @list= @list+ @start+ 
      @name + '"'+colleague.name+'"'+
      @end+","


    end
    @list = @list[0..@list.length-2]
    @list = @list +"]"

    render :inline =>@list


  end

  def list
    @colleagues= Colleague.where(:location=>  params[:loc]).page(params[:page]).per(5).order("id asc")

  end

  def search
    name=params[:search]



    @collegues= @users=Colleague.where(:name=>name)
    @location="["
    @place='"place":'
    @image='"image":'
    @start="{"
    @end="}"
    @collegues.each do |colleague|

      if colleague.attachment.blank?

        p "^^^^^^^^^^^^^^^^"
        p "inside if of controller"

        p "^^^^^^^^^^^^^^^^"


        @location= @location+ @start+ 
        @place + '"'+colleague.location+'",'+
        @image+'"'+'missing-small.png'+'"' +

        @end+","

      else

        @location= @location+ @start+ 
        @place + '"'+colleague.location+'",'+
        @image+'"..'+colleague.attachment.url(:small)+'"' +

        @end+","

      end


    end
    @location = @location[0..@location.length-2]
    @location = @location +"]"
    p "^^^^^^^^^^^^^^^^"
    p @location

    render :inline =>@location
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

    p "inside allpinssss"
    @collegues=Colleague.select("DISTINCT location,longitude,latitude")
    @location="["
    @place='"place":'
    @longitude='"longitude":'
    @latitude='"latitude":'
    @countno='"count":'
    @start="{"
    @end="}"
    @collegues.each do |colleague|
      @count=  Colleague.where(:location=> colleague.location).count 
      @location= @location+ @start+ 
      @place + '"'+colleague.location+'",'+
      @longitude+'"'+colleague.longitude+'",' +
      @latitude+'"'+colleague.latitude+'",'+
      @countno+'"'+ @count.to_s+'"'+
      @end+","


    end
    @location = @location[0..@location.length-2]
    @location = @location +"]"
    p "^^^^^^^^^^^^^^^^"
    p @location

    render :inline =>@location
  end


end
