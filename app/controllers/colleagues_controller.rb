class ColleaguesController < ApplicationController
  # GET /colleagues
  # GET /colleagues.json
  def index

    @colleagues= Colleague.all
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

          flash[:notice] = "Colleague was successfully created."
          format.html { redirect_to @colleague}
          format.json { render json: @colleague, status: :created, location: @colleague }
        else
         flash[:notice] = 'Invalid location!'
         format.html { redirect_to new_colleague_path, notice: 'Invalid location.'}
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
        flash[:notice] = "Colleague was successfully Updated."
        format.html { redirect_to @colleague}
        format.json { head :no_content }
      else
        flash[:notice] = "Colleague was Not Updated."
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


  def autocomplete

    #p "inside autocomplete"

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
    #p "$$$$$$$$$$$$$$$$$$$$$$$"


    #p params[:test]
    @colleagues1=Colleague.where(:location=>  params[:test])

  end
  def locationlist
    loc=params[:loc]



    @collegues= @users=Colleague.where(:location=>loc)
    #p @colleagues


    @location="["
    @place='"cname":'
    @image='"image":'
    @project='"project":'
    @start="{"
    @end="}"
    @collegues.each do |colleague|


      if colleague.attachment.blank?

        # p "^^^^^^^^^^^^^^^^&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
        # p "inside if of controller"

        # p "^^^^^^^^^^^^^^^^"


        @location= @location+ @start+ 
        @place + '"'+colleague.name+'",'+
        @project + '"'+colleague.project+'",'+
        @image+'"'+'../assets/missing-small.png'+'"' +

        @end+","

      else

        @location= @location+ @start+ 
        @place + '"'+colleague.name+'",'+
        @project + '"'+colleague.project+'",'+
        @image+'"..'+colleague.attachment.url(:small)+'"' +

        @end+","

      end





    end
    @location = @location[0..@location.length-2]
    @location = @location +"]"
    # p "^^^^^^^^^^^^^^^^"
    # p @location

    render :inline =>@location

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

        # p "^^^^^^^^^^^^^^^^&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
        # p "inside if of controller"

        # p "^^^^^^^^^^^^^^^^"


        @location= @location+ @start+ 
        @place + '"'+colleague.location+'",'+
        @image+'"'+'../assets/missing-small.png'+'"' +

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
    # p "^^^^^^^^^^^^^^^^"
    # p @location

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

    # p "inside allpinssss"
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
    # p "^^^^^^^^^^^^^^^^"
    # p @location

    render :inline =>@location
  end


end
