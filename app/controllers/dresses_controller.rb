class DressesController < ApplicationController
conn = PG.connect(dbname: 'galinapodstrechnaya', user: 'galinapodstrechnaya')


  def index

    @user = current_user
    conn = PG.connect(dbname: 'galinapodstrechnaya', user: 'galinapodstrechnaya')
  #  @dresses = conn.exec("select * from dresses")


    if @user[:waist] < 26 && @user[:bust] < 33 && @user[:hips] < 37
      @dresses = conn.exec("SELECT * FROM dresses WHERE size && '{XXS}'::text[];")
      @user.revolve = "XXS"
      @user.save
    end

    if @user[:waist] > 24 && @user[:waist] < 27 && @user[:bust] > 31 && @user[:bust] < 34 && @user[:hips] > 35 && @user[:hips] < 38
      # size 4 on asos
      @dresses = conn.exec("SELECT * FROM dresses WHERE size && '{XS}'::text[];");
      @user.revolve = "XS"
      @user.save
    end

    if @user[:waist] > 25 && @user[:waist] < 28 && @user[:bust] > 33 && @user[:bust] < 36 && @user[:hips] > 36 && @user[:hips] < 39
      @dresses = conn.exec("SELECT * FROM dresses WHERE size && '{S}'::text[];");
      @user.revolve = "S"
      @user.save
    end


    if @user[:waist] > 27 && @user[:waist] < 30 && @user[:bust] > 34 && @user[:bust] < 37 && @user[:hips] > 38 && @user[:hips] < 41
      @dresses = conn.exec("SELECT * FROM dresses WHERE size && '{M}'::text[];");
      @user.revolve = "M"
      @user.save
    end

    if @user[:waist] > 28 && @user[:waist] < 31 && @user[:bust] > 35 && @user[:bust] < 38 && @user[:hips] > 39 && @user[:hips] < 42
      @dresses = conn.exec("SELECT * FROM dresses WHERE size && '{L}'::text[];");
      @user.revolve = "L"
      @user.save
    end

    if @user[:waist] > 29 && @user[:waist] > 32 && @user[:bust] > 36 && @user[:bust] < 39  && @user[:hips] > 40 && @user[:hips] < 43
      @dresses = conn.exec("SELECT * FROM dresses WHERE size && '{XL}'::text[];");
      @user.revolve = "XL"
      @user.save
    end

    #@user = User.all
  end

  def show
end
end
