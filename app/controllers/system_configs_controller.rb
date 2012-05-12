class SystemConfigsController < ApplicationController
  # GET /system_configs
  # GET /system_configs.json
  layout 'system_config'
  def index
    @system_configs = SystemConfig.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @system_configs }
    end
  end

  # GET /system_configs/1
  # GET /system_configs/1.json
  def show
    @system_config = SystemConfig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @system_config }
    end
  end

  # GET /system_configs/new
  # GET /system_configs/new.json
  def new
    @system_config = SystemConfig.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @system_config }
    end
  end

  # GET /system_configs/1/edit
  def edit
    @system_config = SystemConfig.find(params[:id])
  end

  # POST /system_configs
  # POST /system_configs.json
  def create
    params[:system_config][:image_types]= params[:image][:types].join(';') rescue nil
    params[:system_config][:file_types] = params[:file][:types].join(';') rescue nil
    params[:system_config][:video_types] = params[:video][:types].join(';') rescue nil
    @system_config = SystemConfig.new(params[:system_config])

    respond_to do |format|
      if @system_config.save
        format.html { redirect_to '/system_configs', notice: 'System config was successfully created.' }
        format.json { render json: @system_config, status: :created, location: @system_config }
      else
        format.html { render action: "new" }
        format.json { render json: @system_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /system_configs/1
  # PUT /system_configs/1.json
  def update
    @system_config = SystemConfig.find(params[:id])
    params[:system_config][:image_types]= params[:image][:types].join(';') if params[:image]  
    params[:system_config][:file_types] = params[:file][:types].join(';') if params[:file]
    params[:system_config][:video_types] = params[:video][:types].join(';') if params[:video]
    respond_to do |format|
      if @system_config.update_attributes(params[:system_config])
        format.html { redirect_to '/system_configs', notice: 'System config was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @system_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_configs/1
  # DELETE /system_configs/1.json
  def destroy
    @system_config = SystemConfig.find(params[:id])
    @system_config.destroy

    respond_to do |format|
      format.html { redirect_to system_configs_url }
      format.json { head :ok }
    end
  end
end
