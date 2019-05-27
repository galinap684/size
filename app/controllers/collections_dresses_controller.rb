class CollectionsDressesController < ApplicationController


    def index
      @collections_dresses = CollectionsDress.all
      @collections = current_user.collections
    end

    def show
      @collections_dress = CollectionsDress.find(params[:id])
    end

    def new
     @collections_dress = CollectionsDress.new(col_params)

       @collections = current_user.collections
    end

    def edit
    end

    def create
@user = current_user
#@user.collections.create(params[:collections])
  #@collections = current_user.collections

# @collections_dress = CollectionsDress.new(params[:collections_dress])
#@collections_dress = CollectionsDress.create(collection_id: @collections.id)
#@collections_dress = CollectionsDress.create(params[:collections_dress])
@collections_dress = CollectionsDress.create(col_params)


respond_to do |format|
  if @collections_dress.save
   format.html { redirect_to '/collections_dresses', notice: 'The item was successfully added.' }
   format.json { render :show, status: :created, location: 'collections_dresses' }
  else
    format.html { render :new }
    format.json { render json: @collection.errors, status: :unprocessable_entity }
  end
end

  end

  def update
    respond_to do |format|
      if @collections_dress.update(col_params)
        format.html { redirect_to @collections_dress, notice: 'Dress was successfully updated.' }
        format.json { render :show, status: :ok, location: @collections_dress }
      else
        format.html { render :edit }
        format.json { render json: @collections_dress.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def col_params
    params.permit(:collection_id, :dress_id)
  end




end
