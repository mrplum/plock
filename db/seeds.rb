
# Create Owner User Company
owner = User.new(name: 'Owner', lastname: 'Plock', email: 'owner@plock.com', password: '123123')

# Craete the company of owner user
c = Company.new(name: 'Plock', description: 'The company', user: owner)

# Owner company also belong to company
owner.company = c

owner.save
c.save

# Create company member user
member_user = User.create(name: 'Slave', lastname: 'One', email: 'slave_1@plock.com', password: '123123', company: c)

# Create the Plockers Team
t = Team.create(name: 'Plockers Team')

# Create a project
project = Project.create(
    name: 'Plock',
    repository: 'Plock is the best',
    cost: 25000,
    start_at: DateTime.now,
    user: owner,
    team: t)

# Add a members to team
t.users << owner
t.users << member_user

# Creating Tracks for this project
track_values = [
    {
        name: 'Track One',
        description: 'Is a example',
        user: owner,
        project: project
    },
    {
        name: 'Track Two',
        description: 'Is a example',
        status: true,
        user: member_user,
        project: project
    },

    {
        name: 'Track Three',
        description: 'Is a example',
        user: member_user,
        project: project
    }
]

track_values.each { |t| Track.create(t) }


# Creating intervals for tracks
t1, t2, t3 = Track.all
t1.intervals.create

interval_1_track_2 = Interval.create(track: t2)
interval_1_track_2.update_attribute(:updated_at, 2.hours.from_now)

interval_2_track_2 = Interval.create(track: t2)
interval_2_track_2.update_attribute(:updated_at, 2.hours.from_now)

t3.intervals.create
