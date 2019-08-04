class DressesController < ApplicationController

  before_action :authorize
  require 'will_paginate/array'

  def index

    @collections = current_user.collections


      @user = current_user
      #  conn = PG.connect(dbname: 'galinapodstrechnaya', user: 'galinapodstrechnaya')
      #  @dresses = conn.exec("select * from dresses")



      if @user[:waist] < 26 && @user[:bust] < 33 && @user[:hips] < 37
        #@dresses = execute_statement("SELECT * FROM dresses WHERE size && '{XXS}'::text[];")
        @dresses = Dress.where("'XXS' = ANY (size)")
        @user.revolve = "XXS"
        @user.save
      end

      if @user[:waist] > 24 && @user[:waist] < 27 && @user[:bust] > 31 && @user[:bust] < 34 && @user[:hips] > 35 && @user[:hips] < 38
        # size 4 on asos
        #@dresses = execute_statement("SELECT * FROM dresses WHERE size && '{XS}'::text[];");
        @dresses = Dress.where("'XS' = ANY (size)")
        @user.revolve = "XS"
        @user.save
      end

      if @user[:waist] > 25 && @user[:waist] < 28 && @user[:bust] > 33 && @user[:bust] < 36 && @user[:hips] > 36 && @user[:hips] < 39
        #@dresses = execute_statement("SELECT * FROM dresses WHERE size && '{S}'::text[];");
        @dresses = Dress.where("'S' = ANY (size)")
        @user.revolve = "S"
        @user.save
      end


      if @user[:waist] > 27 && @user[:waist] < 30 && @user[:bust] > 34 && @user[:bust] < 37 && @user[:hips] > 38 && @user[:hips] < 41
        #@dresses = execute_statement("SELECT * FROM dresses WHERE size && '{M}'::text[];");
        @dresses = Dress.where("'M' = ANY (size)")
        @user.revolve = "M"
        @user.save
      end

      if @user[:waist] > 28 && @user[:waist] < 31 && @user[:bust] > 35 && @user[:bust] < 38 && @user[:hips] > 39 && @user[:hips] < 42
        #@dresses = execute_statement("SELECT * FROM dresses WHERE size && '{L}'::text[];");
        @dresses = Dress.where("'L' = ANY (size)")
        @user.revolve = "L"
        @user.save
      end

      if @user[:waist] > 29 && @user[:waist] < 32 && @user[:bust] > 36 && @user[:bust] < 39  && @user[:hips] > 40 && @user[:hips] < 43
        @dresses = execute_statement("SELECT * FROM dresses WHERE size && '{XL}'::text[];");
        #@dresses = Dress.where("'XL' = ANY (size)")
        @user.revolve = "XL"
        @user.save
      end

    end


  def show
    @dress = Dress.find(params[:id])
    @collections = current_user.collections
    @collections_dress = CollectionsDress.new(col_params)
  end


  def new
    @dress = Dress.new
    @collections_dress = Collections_dress.new
  end


  def edit
  end


  def create
    @user = current_user
    @collections_dress = CollectionsDress.create(col_params)
    @dress.collections_dresses <<  @collections_dress

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

  def destroy
    @dress.destroy
    respond_to do |format|
      format.html { redirect_to dresses_url, notice: 'Dress was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def offset(page, per_page)
    (page - 1) * per_page
  end


    def set_dress
      @dress = Dress.find(params[:id])
    end

    def col_params
      params.permit(:collection_id, :dress_id)
    end

    def dress_params
      params.fetch(:dress, {})
    end
end
