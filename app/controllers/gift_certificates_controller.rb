class GiftCertificatesController < ApplicationController
  # GET /gift_certificates
  # GET /gift_certificates.json
  layout 'features'
  def index
    @gift_certificates = GiftCertificate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gift_certificates }
    end
  end

  # GET /gift_certificates/1
  # GET /gift_certificates/1.json
  def show
    @gift_certificate = GiftCertificate.find(params[:id])
    @gift_certificate.destroy
    redirect_to "/sites/#{params[:site_id]}/gift_certificates"
  end

  # GET /gift_certificates/new
  # GET /gift_certificates/new.json
  def new
    @gift_certificate = GiftCertificate.new
    render :layout => false
  end

  # GET /gift_certificates/1/edit
  def edit
    @gift_certificate = GiftCertificate.find(params[:id])
  end

  # POST /gift_certificates
  # POST /gift_certificates.json
  def create
    @gift_certificate = GiftCertificate.new(params[:gift_certificate])
#    @gift_certificate.assigned_to = User.find_by_username(params[:gift_certificate][:assigned_to]).id

    respond_to do |format|
      if @gift_certificate.save
         format.html { redirect_to "/sites/#{params[:site_id]}/gift_certificates" }
      else
        format.html { render action: "new" }
        format.json { render json: @gift_certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gift_certificates/1
  # PUT /gift_certificates/1.json
  def update
    @gift_certificate = GiftCertificate.find(params[:id])

    respond_to do |format|
      if @gift_certificate.update_attributes(params[:gift_certificate])
        format.html { redirect_to @gift_certificate, notice: 'Gift certificate was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @gift_certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gift_certificates/1
  # DELETE /gift_certificates/1.json
  def destroy
    @gift_certificate = GiftCertificate.find(params[:id])
    @gift_certificate.destroy

    respond_to do |format|
      format.html { redirect_to gift_certificates_url }
      format.json { head :ok }
    end
  end
  
    def approve
    @review = GiftCertificate.find(params[:id])
    @review.status =!@review.status
    @review.save
    redirect_to "/sites/#{params[:site_id]}/gift_certificates"
  end
end
