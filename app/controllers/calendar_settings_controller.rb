class CalendarSettingsController < ApplicationController
  before_action :set_calendar_setting, only: [:show, :edit, :update, :destroy]

  # GET /calendar_settings
  # GET /calendar_settings.json
  def index
    @calendars = Calendar.select('id as calendar_id,name as calendar_name')
    render json: @calendars
  end

  # GET /calendar_settings/1
  # GET /calendar_settings/1.json
  def show
  end

  # GET /calendar_settings/new
  def new
    @calendar_setting = CalendarSetting.new
  end

  # GET /calendar_settings/1/edit
  def edit
  end



  # POST /calendar_settings
  # POST /calendar_settings.json
  def create
    @calendar_setting = CalendarSetting.new(calendar_setting_params)

    respond_to do |format|
      if @calendar_setting.save
        format.html { redirect_to @calendar_setting, notice: 'Calendar setting was successfully created.' }
        format.json { render action: 'show', status: :created, location: @calendar_setting }
      else
        format.html { render action: 'new' }
        format.json { render json: @calendar_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendar_settings/1
  # PATCH/PUT /calendar_settings/1.json
  def update
    respond_to do |format|
      if @calendar_setting.update(calendar_setting_params)
        format.html { redirect_to @calendar_setting, notice: 'Calendar setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @calendar_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendar_settings/1
  # DELETE /calendar_settings/1.json
  def destroy
    @calendar_setting.destroy
    respond_to do |format|
      format.html { redirect_to calendar_settings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar_setting
      @calendar_setting = CalendarSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_setting_params
      params.require(:calendar_setting).permit(:default_view, :popup_time)
    end
end
