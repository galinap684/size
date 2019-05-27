class CollectionsDressesController < ApplicationController
  before_action :authorize


    def index
      @collections_dresses = CollectionsDress.all
      @collections = current_user.collections
    end


    def create
      @user = current_user
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


  private

  def col_params
    params.permit(:collection_id, :dress_id)
  end

end
