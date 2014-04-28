class MoviesController < ApplicationController
#  before_filter :authenticate_admin!, :only => [:edit, :update, :moderate, :destroy, :index]
  load_and_authorize_resource :only => [:edit, :update, :new, :index, :destroy]
  layout "no_side", :only => [:edit, :new, :create, :index]
  # layout 'static_no_head'
   
  # GET /movies
  # GET /movies.xml
  def index
    #this is needed for will_paginate to return a paginated query
    @movies = Movie.page(params[:page]).order('created_at DESC').limit(10)
    #@movies = Movie.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movies }
    end
  end
  
  # GET /movies/browser
  # GET /movies/browser.xml
  def browser
     #this is needed for will_paginate to return a paginated query
    @movies = Movie.page(params[:page]).order('created_at DESC').limit(10)

    respond_to do |format|
      format.html # browser.html.erb
      format.xml  { render :xml => @movies }
    end
  end

  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/new
  # GET /movies/new.xml
  def new
    @movie = Movie.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.xml
  def create
    @movie = Movie.new(params[:movie])

    respond_to do |format|
      if @movie.save
        format.html { redirect_to(@movie, :notice => 'Movie was successfully created.') }
        format.xml  { render :xml => @movie, :status => :created, :location => @movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1
  # PUT /movies/1.xml
  def update
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        format.html { redirect_to(@movie, :notice => 'Movie was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.xml
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to(movies_url) }
      format.xml  { head :ok }
    end
  end
  
  def theater
    @movie = Movie.find(params[:id])

    respond_to do |format|
        format.html # theater.html.erb
        format.xml  { render :xml => @movie }
      
    end
  end
end
