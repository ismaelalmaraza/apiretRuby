class Localbeer
  attr_accessor :id
  attr_accessor :name
  attr_accessor :tagline
  attr_accessor :description
  attr_accessor :abv
  attr_accessor :iduser
  
  def initialize(id, name, tagline, description, abv, iduser)
    @id = id
    @name = name 
    @tagline = tagline
    @description = description
    @abv = abv
    @iduser = iduser
  end
end

class BeersController < ApplicationController
  include HTTParty
  before_action :authenticate!
  before_action :set_beer, only: [:show, :update, :destroy]
  
  def getABeerByAbv
    params[:abv]
    puts "param" + params[:abv]
    get('https://api.punkapi.com/v2/beers?abv_gt=' + params[:abv] )
  end

  def getABeerBynName
    params[:name]
    puts "param" + params[:name]
    get('https://api.punkapi.com/v2/beers?beer_name=' + params[:name] )
  end

  def getMyFavoriteBeer
    token = request.headers["Authorization"]
    iduser = getToken(token)
    @mybeers = []
    @beers = Beer.all
    @beers.each do |beer|
      puts beer['iduser'].to_s + " " + iduser.to_s
      if beer['iduser'].to_s === iduser.to_s
        @mybeers.push beer
      end
    end

    favoriteBeer  = Beer.where("favorite = true")
    render json: favoriteBeer
  end

  def getABeer
    url = 'https://api.punkapi.com/v2/beers/'+params[:id]
    idUser = request.headers["Authorization"]
    id = getToken(idUser)
    @@arreglo=[] 
    var =""
    response = HTTParty.get(url)
    idUser = request.headers["Authorization"]
    response.each do |elemento|
       @@arreglo.push (Localbeer.new(elemento['id'] , elemento['name'], elemento['tagline'] , elemento['description'] , elemento['abv'], id))
       t = Time.now
       var = {
      "name": elemento['name'],
      "tagline":  elemento['tagline'] ,
      "description": elemento['description'],
      "abv": elemento['abv'],
      "iduser":id,
      "see_at": t.strftime("%d/%m/%Y %H:%M:%S"),
      "favorite":false
      }
    end
    saveMyBeer(var)
  end

  def getMyBeers
    token = request.headers["Authorization"]
    iduser = getToken(token)

    puts "my token es " + token
    @mybeers = []
    @beers = Beer.all
    @beers.each do |beer|
      if beer['iduser'].to_s === iduser.to_s
        @mybeers.push beer
      end
    end

    render json: @mybeers
  end

  def setMyFovoriteBeer
    params = {"favorite": 1}

    if @beer.update(params)
      render json: @beer
    else
      render json: @beer.errors, status: :unprocessable_entity
    end
  end

  # GET 
  def index
    get('https://api.punkapi.com/v2/beers')
  end

  # GET
  def show
    render json: @beer
  end

  # POST
  def create
    puts beer_params
    @beer = Beer.new(beer_params)

    if @beer.save
      render json: @beer, status: :created, location: @beer
    else
      render json: @beer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT
  def update
    params = {
      "favorite": beer_params[:favorite]
      }

    if @beer.update(params)
      render json: @beer
    else
      render json: @beer.errors, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    @beer.destroy
  end

  private

    # Ivoke API from url and return json 
    def get(url)
      @@arreglo=[]
      response = HTTParty.get(url)
      response.each do |elemento|
         @@arreglo.push (Localbeer.new(elemento['id'] , elemento['name'], elemento['tagline'] , elemento['description'] , elemento['abv'],""))
      end
      render json: @@arreglo
    end 

    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
      
    end

    # Only allow a trusted parameter "white list" through.
    def beer_params
      params.require(:beer).permit(:name, :tagline, :description, :abv, :iduser, :see_at, :favorite)
    end

    #Get token and retrive user id
    def getToken(token)
      token["Bearer"]= ""
      jsonValues = Auth::JsonWebToken.decode(token.strip)
      return  jsonValues["id"]
    end

    #Save a beer when user see a beer from de list
    def saveMyBeer(beer_params)
      puts beer_params
      @beer = Beer.new(beer_params)
  
      if @beer.save
        render json: @beer, status: :created, location: @beer
      else
        render json: @beer.errors, status: :unprocessable_entity
      end
    end
end
