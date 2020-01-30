
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

project2 = Project.create(
    name: 'Plock2',
    repository: 'Plock is the best2',
    cost: 240,
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
        status: 'Finished',
        user: member_user,
        project: project2
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

datetime = DateTime.now

i1 = t2.intervals.create(user: member_user, start_at: datetime, end_at: datetime)
i1.update(end_at: 2.hours.from_now)

i2 = t2.intervals.create(user: member_user, start_at: datetime, end_at: datetime)
i2.update(end_at: 1.hours.from_now)

i3 = t2.intervals.create(user: member_user, start_at: datetime, end_at: datetime)
i3.update(end_at: 30.minutes.from_now)

i4 = t1.intervals.create(user: member_user, start_at: datetime, end_at: datetime)
i4.update(end_at: 4.hours.from_now)

i5 = t1.intervals.create(user: member_user, start_at: datetime, end_at: datetime)
i5.update(end_at: 20.minutes.from_now)

i6 = t3.intervals.create(user: member_user, start_at: datetime, end_at: datetime)
i6.update(end_at: 50.minutes.from_now)

i7 = t3.intervals.create(user: member_user, start_at: datetime, end_at: datetime)
i7.update(end_at: 5.hours.from_now)

t1.reload
t1.touch

t2.reload
t2.touch

t3.reload
t3.touch

# 1000.times do |i|
#   t = Track.create({
#         name: "Track #{i}",
#         description: 'It\'s a example',
#         user: member_user,
#         project: project
#     })

#   10.times do |i|
#       i = Interval.create(track: t2)
#       i.update_attribute(:updated_at, 10.minutes.from_now)
#     end
# end

