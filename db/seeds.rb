
# Create Owner User Company
owner = User.new(name: 'Owner', lastname: 'Plock', email: 'owner@plock.com', password: '123123')

# Craete the company of owner user
c = Company.new(name: 'Plum', description: 'The company', owner: owner)

# Owner company also belong to company
owner.company = c

owner.save
c.save

# Create company member user
member_user = User.create(name: 'Slave 1', lastname: 'One', email: 'slave_1@plock.com', password: '123123', company: c)
member_user1 = User.create(name: 'Slave 2', lastname: 'Two', email: 'slave_2@plock.com', password: '123123', company: c)
User.create(name: 'Slave 3', lastname: 'Three', email: 'slave_3@plock.com', password: '123123', company: c)

# Create the Plockers Team
t = Team.create(name: 'Plockers Team')

# Create a project
project = Project.create(
    name: 'Plock',
    repository: 'Plock is the best',
    cost: 25000,
    start_at: DateTime.now,
    user: owner,
    team: t,
    company: c
)

project2 = Project.create(
    name: 'Plock2',
    repository: 'Plock is the best2',
    cost: 240,
    start_at: DateTime.now,
    user: owner,
    team: t,
    company: c
)

project3 = Project.create(
    name: 'Plock3',
    repository: 'Plock is the best3',
    cost: 2400,
    start_at: DateTime.now,
    user: member_user1,
    company: c
)

# Add a members to team
t.users << owner
t.users << member_user
t.users << member_user1

t.team_users.each { |team_user|
    team_user.incorporated_at = DateTime.now
    team_user.save
}

# Creating Tracks for this project
track_values = [
    {
        name: 'Track One',
        description: 'Is a example',
        user: owner,
        project: project,
        status: :in_progress
    },
    {
        name: 'Track Two',
        description: 'Is a example',
        status: :finished,
        user: member_user,
        project: project2,
    },
    {
        name: 'Track Three',
        description: 'Is a example',
        status: :finished,
        user: member_user,
        project: project,
    },
    {
        name: 'Track Four',
        description: 'Is a example',
        user: member_user1,
        project: project,
        status: :finished
    },
    {
        name: 'Track Five',
        description: 'Is a example',
        user: owner,
        project: project2,
        status: :in_progress
    },
    {
        name: 'Track Six',
        description: 'Is a example',
        user: member_user,
        project: project2,
        status: :finished
    },
    {
        name: 'Track Seven',
        description: 'Is a example',
        user: member_user1,
        project: project2,
        status: :finished
    },
    {
        name: 'Track Eigth',
        description: 'Is a example',
        user: member_user,
        project: project2,
        status: :in_progress
    },
    {
        name: 'Track Nine',
        description: 'Is a example',
        user: member_user1,
        project: project2,
        status: :in_progress
    },
    {
        name: 'Track Ten',
        description: 'Is a example',
        user: member_user1,
        project: project3,
        status: :finished
    }
]

track_values.each { |t| Track.create(t) }


# Creating intervals for tracks
t1, t2, t3, t4, t5, t6, t7, t8, t9, t10 = Track.all

datetime = DateTime.now

i = t1.intervals.create(
    user: owner, 
    start_at: datetime, 
    end_at: datetime, 
    description: "this is a description of the interval1"
)
i.update(end_at: 4.hours.from_now)

i = t1.intervals.create(
    user: owner, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval2"
)
i.update(end_at: 20.minutes.from_now)

t1.update(updated_at: 1.day.from_now)

i = t2.intervals.create(
    user: member_user, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval3"
)
i.update(end_at: 2.hours.from_now)

i = t2.intervals.create(
    user: member_user, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval4"
)
i.update(end_at: 1.hours.from_now)

t2.update(updated_at: 1.day.from_now)

i = t2.intervals.create(
    user: member_user, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval5"
)
i.update(end_at: 30.minutes.from_now)

t2.update(updated_at: 2.day.from_now)

i = t3.intervals.create(
    user: member_user, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval6"
)
i.update(end_at: 1.hours.from_now)

i = t3.intervals.create(
    user: member_user, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval7"
)
i.update(end_at: 1.hours.from_now)

t3.update(updated_at: 3.day.from_now)

i = t4.intervals.create(
    user: member_user1, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval8"
)
i.update(end_at: 5.hours.from_now)

t4.update(updated_at: 1.day.from_now)

i = t4.intervals.create(
    user: member_user1, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval9"
)
i.update(end_at: 10.minutes.from_now)

t4.update(updated_at: 1.day.from_now)

i = t4.intervals.create(
    user: member_user1, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval10"
)
i.update(end_at: 3.hours.from_now)

t4.update(updated_at: 2.day.from_now)

i = t5.intervals.create(
    user: owner, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval11"
)
i.update(end_at: 20.minutes.from_now)

i = t5.intervals.create(
    user: owner, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval12"
)
i.update(end_at: 10.minutes.from_now)

t5.update(updated_at: 1.day.from_now)

i = t5.intervals.create(
    user: owner, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval13"
)
i.update(end_at: 1.hours.from_now)

i = t6.intervals.create(
    user: member_user, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval14"
)
i.update(end_at: 50.minutes.from_now)

i = t6.intervals.create(
    user: member_user, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval16"
)
i.update(end_at: 1.hours.from_now)

t6.update(updated_at: 1.day.from_now)

i = t7.intervals.create(
    user: member_user1, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval17"
)
i.update(end_at: 5.minutes.from_now)

i = t7.intervals.create(
    user: member_user1, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval18"
)
i.update(end_at: 2.hours.from_now)

t7.update(updated_at: 1.day.from_now)

i = t8.intervals.create(
    user: member_user, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval19"
)
i.update(end_at: 25.minutes.from_now)

i = t9.intervals.create(
    user: member_user1, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval20"
)
i.update(end_at: 30.minutes.from_now)

i = t9.intervals.create(
    user: member_user1,
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval21"
)
i.update(end_at: 5.hours.from_now)

t9.update(updated_at: 1.day.from_now)

i = t10.intervals.create(
    user: member_user1, 
    start_at: datetime, 
    end_at: datetime,
    description: "this is a description of the interval22"
)
i.update(end_at: 5.hours.from_now)


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