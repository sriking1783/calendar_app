class EventController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create

    TableEvent.create!(:event_name => params[:event_name],
                       :start_time => params[:start_date],
                       :end_time => params[:end_date],
                       :repeat => params[:repeat_event],
                       :until => params[:event_end])
    respond_to do |format|
      format.json {render json: {:operation => "successful"}}
    end
  end

  def get_number_of_days(repeat)
    if repeat == "daily"
      return 1
    elsif repeat == "weekly"
      return 7
    end


  end
  def index
    @events = TableEvent.select('event_name as title,start_time as start,end_time as end,repeat,until')

    @exact_event = Array.new
    start_date = Date.new
    end_date = Date.new
    @events.each do |event|
       if event.until.nil?
          @exact_event << {title: event.title,start: start_date,end: end_date}
       else
          number = get_number_of_days(event.repeat)
          start_date = DateTime.parse(event.start)
          end_date = DateTime.parse(event.end)
          while Date.parse(event.until.to_s) > start_date
            @exact_event << {title: event.title,start: start_date,end: end_date}
            start_date = start_date + number.day
            end_date = end_date + number.day
          end
       end
    end
    respond_to do |format|
      format.json {render json: @exact_event}
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
