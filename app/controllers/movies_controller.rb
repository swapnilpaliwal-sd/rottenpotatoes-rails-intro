class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    @ratings_to_show = []
    
    if params[:ratings] == nil 
      if session[:ratings] == nil #check if session n params with ratings attr are empty
        session[:ratings] = {} #empty assigned
        Movie.all_ratings.each do |r|
          session[:ratings][r] = 1 
        end
      end
      @ratings_to_show = session[:ratings].keys #selecting ratings to dsply
    else
      session[:ratings] = params[:ratings]
      @ratings_to_show = session[:ratings].keys #assigning key value which affects the dsply
    end
    
    if params[:ratings] == nil
      redirect_to movies_url(sort_by: params[:sort_by], ratings: session[:ratings])
    end
    
    if session[:ratings]!=nil
      @movies = Movie.where(rating: session[:ratings].keys) #select values when it is not empty
    else
      @movies = Movie.where(rating: params[:ratings].keys)
    end
    if params[:sort_by].to_s == 'title'
      @sort_by_title = "hilite" #one of the 2 additional CSS classes in use 'hilite'
      @movies = @movies.all.order(params[:sort_by])
    elsif params[:sort_by].to_s == 'release_date'
      @sort_by_release_date = "hilite"
      @movies = @movies.all.order(params[:sort_by]) #movies are ordered by selection which is highlighted by yellow color
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
