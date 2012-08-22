class ReviewsController < ApplicationController
  # GET /reviews
  # GET /reviews.json
  layout 'features'
  def index

    @reviews = Review.where('')
    if !params[:query].blank?

      @searchName	=	params[:query]
      @searchOn	=	params[:search_on]
      #if params[:search_on]
        #  user_ids = User.where("name like ?", "%#{params[:query]}%").collect(&:id)
        #  @gift_certificates= @gift_certificates.where("assigned_to in (?)", user_ids)
        #else
      @reviews = @reviews.where("description like ?", "%#{params[:query]}%")
      #end
    end
    if params[:last_login] == "on"
      current_user.last_sign_in_at
      @reviews = @reviews.where(:created_at => (current_user.last_sign_in_at..Time.now))
    end
    #if !params[:date_added].blank?
    #  @reviews = @reviews.where(:created_at => (Date.strptime(params[:start_date],"%m-%d-%Y")..Date.strptime(params[:end_date],"%m-%d-%Y")))
    #end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to "/sites/#{params[:site_id]}/reviews"
  end

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @review = Review.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(params[:review])

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render json: @review, status: :created, location: @review }
      else
        format.html { render action: "new" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :ok }
    end
  end
  
  def approve
    @review = Review.find(params[:id])
    @review.approved =!@review.approved
    @review.save
    redirect_to "/sites/#{params[:site_id]}/reviews"
  end  
end
