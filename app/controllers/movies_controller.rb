class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
    
  def index
    @all_ratings = Movie.all_ratings
    ratings = params[:ratings]
    if ratings != nil
      keys = ratings.keys
      @movies = Movie.where(rating: keys)
    
    end
    type = params[:sort]
    if not type
      @movies=Movie.all
    else
      if type =="bT"
        @movies=Movie.order(:title)
        @tClass = "hilite"
      else
        @movies=Movie.order(:release_date)
        @rClass = "hilite"
      end
    
    end
    
    # if params[:ratings]
    #   h1 = params[:ratings]
    #   h1.each do |k,v|
    #     h = Movie.find_by_rating(k)
    #     @movies=h
    #   end
    # end
        
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
    @movie._update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def upd
  end
  
  def upd_act
    movie = params[:movie]
    @movie = Movie.find_by_title(movie["chk"])
    if @movie==nil
      flash[:notice] = "Movie #{movie["chk"]} not found"
      redirect_to upd_movies_path
    else
      if movie["title"] !=""
        @movie.title = movie["title"]
      end
      if movie["rating"] !=""
        @movie.rating = movie["rating"]
      end
      # odate = @movie.release_date
      if movie["release_date(1i)"] !=""
        y = movie["release_date(1i)"].to_i
        @movie.release_date.change(year: y)
      end
      if movie["release_date(2i)"] !=""
        m=movie["release_date(2i)"].to_i
        @movie.release_date.change(month: m)
      end
      if movie["release_date(3i)"] !=""
        d=movie["release_date(3i)"].to_i
        @movie.release_date.change(day: d)
      end
      @movie.save!
      flash[:notice] = "Movie #{movie["title"]} updated"
      redirect_to movies_path
    end
  end

  def mov_del
    movie = params[:movie]
    if movie["title"] !=""
      @movie = Movie.find_by_title(movie["title"])
      @movie.destroy
      flash[:notice] = "Movie '#{@movie.title}' deleted."
    end
    
    if movie["rating"] != ""
      @movie = Movie.find_by_rating(movie["rating"])
      while @movie != nil
        @movie.destroy
        flash[:notice] = "Movie '#{@movie.title}' deleted."
        @movie = Movie.find_by_rating(movie["rating"])
      end
    end
    redirect_to movies_path
  end

  def delete
  end

end
