module GenerateEvents
  def self.get_all_events(events)


    exact_events = Array.new
    start_date = Date.new
    end_date = Date.new
    events.each do |event|
       if event.until.nil?
        exact_events << {title: event.title, start: event.start, end: event.end }
       else
          number = self.get_number_of_days(event.repeat)
          start_date = DateTime.parse(event.start)
          end_date = DateTime.parse(event.end)
          while Date.parse(event.until.to_s) > start_date
            exact_events << {title: event.title, start: start_date, end: end_date}
            start_date = start_date + number.day
            end_date = end_date + number.day
          end
       end
    end
    exact_events
  end

  def self.get_number_of_days(repeat)
    if repeat == "daily"
      return 1
    elsif repeat == "weekly"
      return 7
    end
  end

  def self.is_overlapping?(event,all_events)
    exact_events = self.get_all_events(all_events)


    exact_events.each do |s_event|
      if DateTime.parse(event[:start_time]) >= s_event[:start] && DateTime.parse(event[:end_time]) <= s_event[:end]
        puts "HERE 1"
        return true
      elsif DateTime.parse(event[:end_time]) >= s_event[:start] && DateTime.parse(event[:end_time]) <= s_event[:end]
        puts "HERE 2"
        return true
      elsif DateTime.parse(event[:start_time]) >= s_event[:start] && DateTime.parse(event[:start_time]) <= s_event[:end]
        puts "HERE 3"
        return true
      end
     end

     return false
  end

end