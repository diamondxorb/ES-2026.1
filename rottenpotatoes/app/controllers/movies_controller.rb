class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]

  def index
    @movies = Movie.all

    if params[:search].present?
      @movies = @movies.where("title LIKE ?", "%#{params[:search]}%")
    end

    if params[:rating].present? && params[:rating] != "all"
      @movies = @movies.where(rating: params[:rating])
    end

    case params[:sort]
    when "title"
      @movies = @movies.order(:title)
    when "release_date"
      @movies = @movies.order(:release_date)
    else
      @movies = @movies.order(created_at: :desc)
    end
  end

  def show; end

  def new
    @movie = Movie.new
  end

  def edit; end

  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie.destroy!

    respond_to do |format|
      format.html {redirect_to movies_path, status: :see_other, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search_tmdb
    search_terms = params[:search_terms]
    
    if search_terms.blank?
      @tmdb_error = "Please enter a search term."
      redirect_to movies_path
      return
    end

    # Simulação de busca no TMDb
    # Em uma implementação real, você faria uma chamada HTTP à API do TMDb
    tmdb_movies = search_tmdb_movies(search_terms)

    if tmdb_movies.empty?
      @tmdb_error = "'#{search_terms}' was not found in TMDb."
      redirect_to movies_path, flash: { error: @tmdb_error }
    else
      # Se encontrou, você poderia redirecionar para uma página de seleção
      # ou criar um novo filme automaticamente
      redirect_to movies_path, notice: "Found #{tmdb_movies.length} movie(s) in TMDb."
    end
  end

  private

  def search_tmdb_movies(query)
    # Implementação simulada - em produção, você chamaria a API do TMDb
    # Por enquanto, retorna sempre vazio para qualquer busca
    # Você pode adicionar filmes específicos para testes aqui
    []
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :image)
  end
end