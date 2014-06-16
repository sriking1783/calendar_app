class EventController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    TableEvent.create!(:event_name => params[:event_name],:start_time => params[:start_date],:end_time => params[:end_date])
    respond_to do |format|
      format.json {render json: {:operation => "successful"}}
    end
  end

  def index
    @events = TableEvent.select('event_name as title,start_time as start,end_time as end')
    respond_to do |format|
      format.json {render json: @events}
    end
  end

  def next_event
    @events = TableEvent.where('start_time > ? OR end_time > ?',Time.now + 15.minutes,Time.now + 30.minutes)
    respond_to do |format|
      format.json {render json: @events}
    end
  end

  def delete
  end

  def update
  end
end
