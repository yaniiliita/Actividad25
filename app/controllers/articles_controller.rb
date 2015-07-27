class ArticlesController < ApplicationController

	before_action :authenticate_user!, except: [:show, :index]
	before_action :set_article, except: [:index, :new, :create]


	#GET /articles
	def index
		# Todos los registros SELECT * FROM articles
		@articles = Article.all
	end

	#GET /articles/:id
	def show
		@articles.update_visits_count
		@comment = Comment.new
	end
	
	#GET /articles/new
	def new
		@articles = Article.new
		@categories = Category.all
	end

	def edit
		
	end
	
	#POST /articles
	def create
		#INSERT INTO
		@articles = current_user.articles.new(article_params)
		@articles.categories = params[:categories]
		if @articles.save
			redirect_to @articles
		else
			render :new
		end
	end

	#DELETE /articles/:id
	def destroy
		#DELETE FROM articles
		
		@articles.destroy #Destroy elimina el obketo de la BD
		redirect_to articles_path
	end

	#PUT /articles/:id
	def update
		if @articles.update(article_params)
			redirect_to @articles
		else
			render :edit
		end
	end

	private
	def article_params
		params.require(:article).permit(:title, :body, :cover, :categories)
	end

	def set_article
		@articles = Article.find(params[:id])
	end

end