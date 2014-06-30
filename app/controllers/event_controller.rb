class EventController < ApplicationController
  include GenerateEvents
  skip_before_filter :verify_authenticity_token

  def create

    @events = TableEvent.select('event_name as title,start_time as start,end_time as end,repeat,until').where('calendar_id=?',session[:calendar_id])
    event = {:event_name => params[:event_name],
                       :start_time => params[:start_date],
                       :end_time => params[:end_date],
                       :repeat => params[:repeat_event],
                       :until => params[:event_end],
                       :calendar_id => session[:calendar_id]
            }
    if GenerateEvents::is_overlapping?(event,@events)
      respond_to do |format|
        format.json {render json: {:operation => "unsuccessful"}}
      end
    else
      TableEvent.create!(event)
      respond_to do |format|
        format.json {render json: {:operation => "successful"}}
      end
    end
  end

  def create_session
    session[:calendar_id] = nil
    session[:calendar_id] = params[:calendar_id]
    respond_to do |format|
      format.json {render json: {:operation => "successful"}}
    end
  end

  def index
    @events = TableEvent.select('event_name as title,start_time as start,end_time as end,repeat,until').where('calendar_id=?',session[:calendar_id])
    @exact_events = GenerateEvents::get_all_events(@events)
    respond_to do |format|
      format.json {render json: @exact_events.to_json}
    end
  end

  def next_event
    @events = TableEvent.where('start_time > ?',Time.now + 15.minutes)
    respond_to do |format|
      format.json {render json: @events}
    end
  end

  def delete
  end

  def update
  end
end
