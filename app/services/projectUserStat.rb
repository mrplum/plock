class ProjectUserStat
    def initialize(user)
        @user = user
    end
  
    def call
        cont = 0
        @user.tracks.all.each do |track| 
            a = UserTrackStat.new(track).call
            b = a.to_s.split(".")[1].to_f
            cont = ( cont + (a.round * 60 ) + b ).to_f  
        end
        return (((cont/60).to_f).round(2))
    end
end    
             