class UserTrackStat
    def initialize(track)
        @track = track
    end
  
    def call
        difference = ((@track.ends_at - @track.starts_at)).to_i
        hours =  (difference / 1.hour)
        minutes = (difference / 1.minute) % 1.minute.to_i
        "#{hours}.#{minutes}".to_f
    end
end    
                      