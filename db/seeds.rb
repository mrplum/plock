
# Create Owner User Company
owner = User.new(name: 'Owner', lastname: 'Plock', email: 'owner@plock.com', password: '123123')

# Craete the company of owner user
c = Company.new(name: 'Plum', description: 'The company', owner: owner)

# Owner company also belong to company
owner.company = c

owner.save
c.save

# Create company member user
member_user = User.create(
    name: 'Slave 1',
    lastname: 'One',
    email: 'slave_1@plock.com',
    password: '123123', company: c
)
member_user1 = User.create(
    name: 'Slave 2',
    lastname: 'Two',
    email: 'slave_2@plock.com',
    password: '123123', company: c
)
User.create(
    name: 'Slave 3',
    lastname: 'Three',
    email: 'slave_3@plock.com',
    password: '123123',
    company: c
)

# Create the Plockers Team
t = Team.create(name: 'Plockers Team')

datetime = DateTime.now
date_project = 2.months.ago

# Create a projects

project = Project.create(
    name: 'Plock',
    description: 'Plock is the best',
    cost: 25000,
    start_at: date_project,
    user: owner,
    team: t,
    company: c
)

project2 = Project.create(
    name: 'Plock2',
    description: 'Plock is the best2',
    cost: 240,
    start_at: date_project,
    user: owner,
    team: t,
    company: c
)

project3 = Project.create(
    name: 'Plock3',
    description: 'Plock is the best3',
    cost: 2400,
    start_at: date_project,
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
    },
    {
        name: 'Track Eleven',
        description: 'Is a example',
        user: member_user,
        project: project,
    }
]

track_values.each { |t| Track.create(t) }


# Creating intervals for tracks
t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11 = Track.all

t1.intervals.create(
    description: "this is a description of the interval",
    user: owner,
    start_at: datetime - 4.month,
    end_at: (datetime - 4.month) + 60.minutes
)

t1.intervals.create(
    description: "this is a description of the interval1",
    user: owner,
    start_at: datetime - 3.month,
    end_at: (datetime - 3.month) + 30.minutes
)

t1.intervals.create(
    description: "this is a description of the interval2",
    user: owner,
    start_at: datetime - 2.month,
    end_at: (datetime - 2.month) + 10.minutes
)


t1.intervals.create(
    description: "this is a description of the interval3",
    user: owner,
    start_at: datetime - 1.month,
    end_at: (datetime - 1.month) + 25.minutes
)

t2.intervals.create(
    description: "this is a description of the interval4",
    user: owner,
    start_at: datetime - 4.month,
    end_at: (datetime - 4.month) + 50.minutes
)

t4.intervals.create(
    description: "this is a description of the interval5",
    user: member_user1,
    start_at: datetime - 4.month,
    end_at: (datetime - 4.month) + 30.minutes
)

t4.intervals.create(
    description: "this is a description of the interval6",
    user: member_user1,
    start_at: datetime - 3.month,
    end_at: (datetime - 3.month) + 20.minutes
)

t4.intervals.create(
    description: "this is a description of the interval7",
    user: member_user1,
    start_at: datetime - 2.month,
    end_at: (datetime - 2.month) + 10.minutes
)

t5.intervals.create(
    description: "this is a description of the interval8",
    user: owner,
    start_at: datetime - 4.month,
    end_at: (datetime - 4.month) + 25.minutes
)

t5.intervals.create(
    description: "this is a description of the interval9",
    user: owner,
    start_at: datetime - 3.month,
    end_at: (datetime - 3.month) + 30.minutes
)

t5.intervals.create(
    description: "this is a description of the interval10",
    user: owner,
    start_at: datetime - 2.month,
    end_at: (datetime - 2.month) + 12.minutes
)

t5.intervals.create(
    description: "this is a description of the interval11",
    user: owner,
    start_at: datetime - 1.month,
    end_at: (datetime - 1.month) + 18.minutes
)

t6.intervals.create(
    description: "this is a description of the interval12",
    user: member_user,
    start_at: datetime - 2.month,
    end_at: (datetime - 2.month) + 30.minutes
)

t6.intervals.create(
    description: "this is a description of the interval13",
    user: member_user,
    start_at: (datetime - 2.month) - 1.day,
    end_at: ((datetime - 2.month) - 1.day) + 30.minutes
)

t6.intervals.create(
    description: "this is a description of the interval14",
    user: member_user,
    start_at: datetime - 1.month,
    end_at: (datetime - 1.month) + 30.minutes
)

t7.intervals.create(
    description: "this is a description of the interval15",
    user: member_user1,
    start_at: (datetime - 4.month) + 1.day,
    end_at: ((datetime - 4.month) + 1.day) + 30.minutes
)

t7.intervals.create(
    description: "this is a description of the interval16",
    user: member_user1,
    start_at: (datetime - 4.month) + 2.day,
    end_at: ((datetime - 4.month) + 2.day) + 25.minutes
)

t7.intervals.create(
    description: "this is a description of the interval17",
    user: member_user1,
    start_at: (datetime - 4.month) + 3.day,
    end_at: ((datetime - 4.month) + 3.day) + 50.minutes
)

t7.intervals.create(
    description: "this is a description of the interval18",
    user: member_user1,
    start_at: (datetime - 4.month) + 4.day,
    end_at: ((datetime - 4.month) + 4.day) + 25.minutes
)

t8.intervals.create(
    description: "this is a description of the interval19",
    user: member_user,
    start_at: (datetime - 3.month) - 2.day,
    end_at: ((datetime - 3.month) - 2.day) + 25.minutes
)

t8.intervals.create(
    description: "this is a description of the interval20",
    user: member_user,
    start_at: (datetime - 2.month) - 3.day,
    end_at: ((datetime - 2.month) - 3.day) + 50.minutes
)

t8.intervals.create(
    description: "this is a description of the interval21",
    user: member_user,
    start_at: (datetime - 1.month) - 1.day,
    end_at: ((datetime - 1.month) - 1.day) + 25.minutes
)

t9.intervals.create(
    description: "this is a description of the interval22",
    user: member_user,
    start_at: (datetime - 3.month) - 2.day,
    end_at: ((datetime - 3.month) - 2.day) + 30.minutes
)

t9.intervals.create(
    description: "this is a description of the interval23",
    user: member_user,
    start_at: (datetime - 2.month) - 3.day,
    end_at: ((datetime - 2.month) - 3.day) + 45.minutes
)

t9.intervals.create(
    description: "this is a description of the interval24",
    user: member_user,
    start_at: (datetime - 1.month) - 1.day,
    end_at: ((datetime - 1.month) - 1.day) + 25.minutes
)

t10.intervals.create(
    description: "this is a description of the interval25",
    user: member_user1,
    start_at: datetime - 2.month,
    end_at: (datetime - 2.month) + 30.minutes
)

t10.intervals.create(
    description: "this is a description of the interval26",
    user: member_user1,
    start_at: datetime - 2.month,
    end_at: (datetime - 2.month) + 30.minutes
)

t10.intervals.create(
    description: "this is a description of the interval27",
    user: member_user1,
    start_at: datetime - 2.month,
    end_at: (datetime - 2.month) + 30.minutes
)


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