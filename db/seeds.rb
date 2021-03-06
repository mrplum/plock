# # Create Owner User Company...
# ActiveRecord::Migration.say_with_time("Creating UNRC Structure & Examples..") do
#   owner = User.find_or_create_by(
#     name: 'Owner',
#     lastname: 'Plock',
#     email: 'owner@plock.com',
#     admin: true)
#   owner.password = '123123'
#   owner.save!

#   ActiveRecord::Migration.say("User #{owner.name}: #{owner.persisted?}")


#   # Create the company of owner user...
#   company = Company.find_or_create_by(
#     name: 'UNRC',
#     description: 'The company',
#     email: 'company@plock.com',
#     owner_id: owner.id)
#   ActiveRecord::Migration.say("Company #{company.name}: #{company.persisted?}")

#   owner.update(company: company)


#   # Creating Company Users...
#   user_one = User.find_or_create_by(
#     name: 'User 1',
#     lastname: 'One',
#     email: 'user_1@plock.com',
#     company: company)
#   user_one.password = '123123'
#   user_one.save
#   ActiveRecord::Migration.say("User #{user_one.name}: #{user_one.persisted?}")

#   user_two = User.find_or_create_by(
#       name: 'User 2',
#       lastname: 'Two',
#       email: 'user_2@plock.com',
#       company: company)
#   user_two.password = '123123'
#   ActiveRecord::Migration.say("User #{user_two.name}: #{user_one.persisted?}")

#   user_three = User.find_or_create_by(
#     name: 'User 3',
#     lastname: 'Three',
#     email: 'user_3@plock.com',
#     company: company)
#   user_three.password = '123123'
#   user_three.save
#   ActiveRecord::Migration.say("User #{user_three.name}: #{user_one.persisted?}")


#   # Create Areas
#   area_1 = Area.find_or_create_by(company: company, name: 'Fac. Exactas')
#   ActiveRecord::Migration.say("User #{area_1.name}: #{area_1.persisted?}")

#   area_2 = Area.find_or_create_by(company: company, name: 'Fac. Humanas')
#   ActiveRecord::Migration.say("User #{area_2.name}: #{area_2.persisted?}")

#   area_3 = Area.find_or_create_by(company: company, name: 'Fac. Económica')
#   ActiveRecord::Migration.say("User #{area_3.name}: #{area_3.persisted?}")


#   # Creating Projects/Dependencies
#   datetime = DateTime.now
#   date_project = 2.years.ago

#   dep1 = Project.find_or_create_by(
#     name: 'Departamento de Computación',
#     description: 'Plock ',
#     cost: 25000,
#     start_at: date_project,
#     user: owner,
#     company: company,
#     area: area_1)
#   ActiveRecord::Migration.say("Project/Dependencia #{dep1.name}: #{dep1.persisted?}")

#   dep2 = Project.find_or_create_by(
#     name: 'Departamento de Matemática',
#     description: 'Plock ',
#     cost: 240,
#     start_at: date_project,
#     user: owner,
#     company: company,
#     area: area_1)
#   ActiveRecord::Migration.say("Project/Dependencia #{dep2.name}: #{dep2.persisted?}")

#   dep3 = Project.find_or_create_by(
#     name: 'Abogacia',
#     description: 'Plock',
#     cost: 2400,
#     start_at: date_project,
#     user: user_one,
#     company: company,
#     area: area_2)
#   ActiveRecord::Migration.say("Project/Dependencia #{dep3.name}: #{dep3.persisted?}")

#   dep4 = Project.find_or_create_by(
#     name: 'SIC III',
#     description: 'Plock',
#     cost: 2400,
#     start_at: date_project,
#     user: user_one,
#     company: company,
#     area: area_3)
#   ActiveRecord::Migration.say("Project/Dependencia #{dep4.name}: #{dep4.persisted?}")


#   # Create Teams/Oficinas
#   office1 = Team.find_or_create_by(name: 'Oficia A11')
#   office1.projects << dep1 unless dep1.in?(office1.projects)
#   ActiveRecord::Migration.say("Team/Oficina #{office1.name}: #{office1.persisted?}")

#   office2 = Team.find_or_create_by(name: 'Oficia A13')
#   office2.projects << dep1 unless dep1.in?(office2.projects)
#   ActiveRecord::Migration.say("Team/Oficina #{office2.name}: #{office2.persisted?}")

#   office3 = Team.find_or_create_by(name: 'Smith')
#   office3.projects << dep2 unless dep2.in?(office3.projects)
#   ActiveRecord::Migration.say("Team/Oficina #{office3.name}: #{office3.persisted?}")

#   office4 = Team.find_or_create_by(name: 'O. Derecho')
#   office4.projects << dep3 unless dep3.in?(office4.projects)
#   ActiveRecord::Migration.say("Team/Oficina #{office4.name}: #{office4.persisted?}")

#   office5 = Team.find_or_create_by(name: 'Of. Catedra 1')
#   office5.projects << dep4 unless dep4.in?(office5.projects)
#   ActiveRecord::Migration.say("Team/Oficina #{office5.name}: #{office5.persisted?}")

#   # Add a members to teams
#   office1.users << owner
#   ActiveRecord::Migration.say("#{owner.name} added to #{office1.name}")
#   office1.users << user_one
#   ActiveRecord::Migration.say("#{user_one.name} added to #{office1.name}")
#   office1.users << user_two
#   ActiveRecord::Migration.say("#{user_two.name} added to #{office1.name}")

#   office1.team_users.each { |team_user|
#     team_user.incorporated_at = DateTime.now
#     team_user.save
#   }


#   office2.users << owner
#   ActiveRecord::Migration.say("#{owner.name} added to #{office2.name}")
#   office2.users << user_three
#   ActiveRecord::Migration.say("#{user_three.name} added to #{office2.name}")
#   office2.team_users.each { |team_user|
#     team_user.incorporated_at = DateTime.now
#     team_user.save
#   }

#   office3.users << owner
#   ActiveRecord::Migration.say("#{owner.name} added to #{office3.name}")

#   office4.users << owner
#   ActiveRecord::Migration.say("#{owner.name} added to #{office4.name}")

#   office5.users << owner
#   ActiveRecord::Migration.say("#{owner.name} added to #{office5.name}")

#   # Creating Tracks for this project
#   track_values = [
#     {
#       name: 'Jornada Día One',
#       description: 'Is a example',
#       user: owner,
#       project: dep1,
#       team: office1,
#       status: :in_progress
#     },
#     {
#       name: 'Jornada Día Two',
#       description: 'Is a example',
#       status: :finished,
#       user: user_one,
#       project: dep1,
#       team: office1,
#     },
#     {
#       name: 'Jornada Día Three',
#       description: 'Is a example',
#       status: :finished,
#       project: dep1,
#       team: office1,
#       user: owner,
#     },
#     {
#       name: 'Jornada Día Four',
#       description: 'Is a example',
#       user: user_one,
#       project: dep1,
#       team: office1,
#       status: :finished
#     },
#     {
#       name: 'Jornada Día Five',
#       description: 'Is a example',
#       project: dep1,
#       team: office2,
#       status: :in_progress,
#       user: user_two
#     },
#     {
#         name: 'Jornada Día Six',
#         description: 'Is a example',
#         project: dep1,
#         team: office2,
#         status: :finished,
#         user: user_two
#     },
#     {
#         name: 'Jornada Día Seven',
#         description: 'Is a example',
#         user: owner,
#         project: dep2,
#         status: :finished,
#         team: office2,
#     },
#     {
#         name: 'Jornada Día Eigth',
#         description: 'Is a example',
#         user: owner,
#         project: dep2,
#         status: :in_progress,
#         team: office2
#     },
#     {
#         name: 'Jornada Día Nine',
#         description: 'Is a example',
#         user: user_one,
#         project: dep2,
#         status: :in_progress,
#         team: office1,
#     },
#     {
#         name: 'Jornada Día Ten',
#         description: 'Is a example',
#         user: user_three,
#         project: dep2,
#         team: office2,
#         status: :finished
#     },
#     {
#         name: 'Jornada Día Eleven',
#         description: 'Is a example',
#         user: user_three,
#         project: dep2,
#         team: office2,
#     }
#   ]

#   track_values.each_with_index do |t, index|
#     t = Track.create(t)
#     ActiveRecord::Migration.say(
#       "[#{index}] Creating track/tareas: #{t.name} to #{t.user.name} in Team #{t.team.name}: #{t.persisted?}")
#   end


#   # Creating intervals for tracks
#   t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11 = Track.all

#   t1_intervals = [
#     {
#       description: "this is a description of the interval",
#       user: owner,
#       start_at: datetime - 4.month,
#       end_at: (datetime - 4.month) + 60.minutes
#     },
#     {
#       description: "this is a description of the interval1",
#       user: owner,
#       start_at: datetime - 3.month,
#       end_at: (datetime - 3.month) + 30.minutes
#     },
#     {
#       description: "this is a description of the interval2",
#       user: owner,
#       start_at: datetime - 2.month,
#       end_at: (datetime - 2.month) + 10.minutes
#     },
#     {
#       description: "this is a description of the interval3",
#       user: owner,
#       start_at: datetime - 1.month,
#       end_at: (datetime - 1.month) + 25.minutes
#     },
#     {
#       description: "this is a description of the interval4",
#       user: owner,
#       start_at: datetime - 4.month,
#       end_at: (datetime - 4.month) + 50.minutes
#     }
#   ]

#   t1_intervals.each_with_index do |interval, index|
#     i = t1.intervals.create(interval)
#     ActiveRecord::Migration.say("[#{index}] Adding #{i.send(:calculate_minutes)} to #{i.track.name}: #{i.persisted?}")
#   end

#   i_t2 = t2.intervals.create({
#     description: "whole",
#     user: user_two,
#     start_at: datetime - 2.month,
#     end_at: (datetime - 2.month) + 10.minutes
#   })
#   ActiveRecord::Migration.say(
#     "Adding #{i_t2.send(:calculate_minutes)} to #{i_t2.track.name}: #{i_t2.persisted?}")

#   t3_intervals =[
#     {
#       description: "this is a description of the interval5",
#       user: user_one,
#       start_at: datetime - 4.month,
#       end_at: (datetime - 4.month) + 30.minutes
#     },
#     {
#       description: "this is a description of the interval6",
#       user: user_one,
#       start_at: datetime - 3.month,
#       end_at: (datetime - 3.month) + 20.minutes
#     },
#     {
#       description: "this is a description of the interval7",
#       user: user_one,
#       start_at: datetime - 2.month,
#       end_at: (datetime - 2.month) + 10.minutes
#     }
#   ]

#   t3_intervals.each_with_index do |interval, index|
#     i = t3.intervals.create(interval)
#     ActiveRecord::Migration.say("[#{index}] Adding #{i.send(:calculate_minutes)} to #{i.track.name}: #{i.persisted?}")
#   end

#   t5_intervals =[
#     {
#       description: "this is a description of the interval8",
#       user: user_two,
#       start_at: datetime - 4.month,
#       end_at: (datetime - 4.month) + 10.minutes
#     },
#     {
#       description: "this is a description of the interval9",
#       user: user_two,
#       start_at: datetime - 3.month,
#       end_at: (datetime - 3.month) + 35.minutes
#     },
#     {
#       description: "this is a description of the interval10",
#       user: user_two,
#       start_at: datetime - 2.month,
#       end_at: (datetime - 2.month) + 15.minutes
#     }
#   ]

#   t5_intervals.each_with_index do |interval, index|
#     i = t5.intervals.create(interval)
#     ActiveRecord::Migration.say("[#{index}] Adding #{i.send(:calculate_minutes)} to #{i.track.name}: #{i.persisted?}")
#   end

#   t8_intervals =[
#     {
#       description: "this is a description of the interval11",
#       user: owner,
#       start_at: datetime - 4.month,
#       end_at: (datetime - 4.month) + 20.minutes
#     },
#     {
#       description: "this is a description of the interval12",
#       user: owner,
#       start_at: datetime - 3.month,
#       end_at: (datetime - 3.month) + 30.minutes
#     },
#     {
#       description: "this is a description of the interval13",
#       user: owner,
#       start_at: datetime - 2.month,
#       end_at: (datetime - 2.month) + 25.minutes
#     }
#   ]

#   t8_intervals.each_with_index do |interval, index|
#     i = t8.intervals.create(interval)
#     ActiveRecord::Migration.say("[#{index}] Adding #{i.send(:calculate_minutes)} to #{i.track.name}: #{i.persisted?}")
#   end

#   t9_intervals =[
#     {
#       description: "this is a description of the interval14",
#       user: user_one,
#       start_at: datetime - 4.month,
#       end_at: (datetime - 4.month) + 30.minutes
#     },
#     {
#       description: "this is a description of the interval15",
#       user: user_one,
#       start_at: datetime - 3.month,
#       end_at: (datetime - 3.month) + 15.minutes
#     },
#     {
#       description: "this is a description of the interval16",
#       user: user_one,
#       start_at: datetime - 2.month,
#       end_at: (datetime - 2.month) + 35.minutes
#     }
#   ]

#   t9_intervals.each_with_index do |interval, index|
#     i = t9.intervals.create(interval)
#     ActiveRecord::Migration.say("[#{index}] Adding #{i.send(:calculate_minutes)} to #{i.track.name}: #{i.persisted?}")
#   end
# end

# 1000.times do |i|
#   t = Track.create({
#         name: "Track #{i}",
#         description: 'It\'s a example',
#         user: user_one,
#         project: project
#     })

#   10.times do |i|
#       i = Interval.create(track: t2)
#       i.update_attribute(:updated_at, 10.minutes.from_now)
#     end
# end


# Create Owner User Company...
ActiveRecord::Migration.say_with_time("Creating PLUM Structure & Examples..") do
  owner = User.find_or_create_by(
    name: 'Owner',
    lastname: 'Plock',
    email: 'owner@plock.com',
    admin: true)
  owner.password = '123123'
  owner.save!

  ActiveRecord::Migration.say("User #{owner.name}: #{owner.persisted?}")


  # Create the company of owner user...
  company = Company.find_or_create_by(
    name: 'PLUM',
    description: 'The company',
    email: 'plum@plock.com',
    owner_id: owner.id)
  ActiveRecord::Migration.say("Company #{company.name}: #{company.persisted?}")

  owner.update(company: company)


  # Creating Company Users...
  user_one = User.find_or_create_by(
    name: 'User 1',
    lastname: 'One',
    email: 'user_1@plock.com',
    company: company)
  user_one.password = '123123'
  user_one.save
  ActiveRecord::Migration.say("User #{user_one.name}: #{user_one.persisted?}")

  user_two = User.find_or_create_by(
      name: 'User 2',
      lastname: 'Two',
      email: 'user_2@plock.com',
      company: company)
  user_two.password = '123123'
  ActiveRecord::Migration.say("User #{user_two.name}: #{user_one.persisted?}")

  user_three = User.find_or_create_by(
    name: 'User 3',
    lastname: 'Three',
    email: 'user_3@plock.com',
    company: company)
  user_three.password = '123123'
  user_three.save
  ActiveRecord::Migration.say("User #{user_three.name}: #{user_one.persisted?}")


  # Create Areas
  # area_1 = Area.find_or_create_by(company: company, name: 'Fac. Exactas')
  # ActiveRecord::Migration.say("User #{area_1.name}: #{area_1.persisted?}")

  # area_2 = Area.find_or_create_by(company: company, name: 'Fac. Humanas')
  # ActiveRecord::Migration.say("User #{area_2.name}: #{area_2.persisted?}")

  # area_3 = Area.find_or_create_by(company: company, name: 'Fac. Económica')
  # ActiveRecord::Migration.say("User #{area_3.name}: #{area_3.persisted?}")


  # Creating Projects
  datetime = DateTime.now
  date_project = 2.years.ago

  project1 = Project.find_or_create_by(
    name: 'Project test 1',
    description: 'Plock ',
    cost: 25000,
    start_at: date_project,
    user: owner,
    company: company
  )
  ActiveRecord::Migration.say("Project #{project1.name}: #{project1.persisted?}")

  project2 = Project.find_or_create_by(
    name: 'Project test 2',
    description: 'Plock ',
    cost: 240,
    start_at: date_project,
    user: owner,
    company: company
  )
  ActiveRecord::Migration.say("Project #{project2.name}: #{project2.persisted?}")

  project3 = Project.find_or_create_by(
    name: 'Project test 3',
    description: 'Plock',
    cost: 2400,
    start_at: date_project,
    user: user_one,
    company: company
  )
  ActiveRecord::Migration.say("Project #{project3.name}: #{project3.persisted?}")

  project4 = Project.find_or_create_by(
    name: 'Project test 4',
    description: 'Plock',
    cost: 2400,
    start_at: date_project,
    user: user_one,
    company: company
  )
  ActiveRecord::Migration.say("Project #{project4.name}: #{project4.persisted?}")


  # Create Teams
  team1 = Team.find_or_create_by(name: 'Team 1')
  team1.projects << project1 unless project1.in?(team1.projects)
  ActiveRecord::Migration.say("Team #{team1.name}: #{team1.persisted?}")

  team2 = Team.find_or_create_by(name: 'Team 2')
  team2.projects << project1 unless project1.in?(team2.projects)
  ActiveRecord::Migration.say("Team #{team2.name}: #{team2.persisted?}")

  team3 = Team.find_or_create_by(name: 'Team 3')
  team3.projects << project2 unless project2.in?(team3.projects)
  ActiveRecord::Migration.say("Team #{team3.name}: #{team3.persisted?}")

  team4 = Team.find_or_create_by(name: 'Team 4')
  team4.projects << project3 unless project3.in?(team4.projects)
  ActiveRecord::Migration.say("Team #{team4.name}: #{team4.persisted?}")

  team5 = Team.find_or_create_by(name: 'Team 5')
  team5.projects << project4 unless project4.in?(team5.projects)
  ActiveRecord::Migration.say("Team #{team5.name}: #{team5.persisted?}")

  # Add a members to teams
  team1.users << owner
  ActiveRecord::Migration.say("#{owner.name} added to #{team1.name}")
  team1.users << user_one
  ActiveRecord::Migration.say("#{user_one.name} added to #{team1.name}")
  team1.users << user_two
  ActiveRecord::Migration.say("#{user_two.name} added to #{team1.name}")

  team1.team_users.each { |team_user|
    team_user.incorporated_at = DateTime.now
    team_user.save
  }


  team2.users << owner
  ActiveRecord::Migration.say("#{owner.name} added to #{team2.name}")
  team2.users << user_three
  ActiveRecord::Migration.say("#{user_three.name} added to #{team2.name}")
  team2.team_users.each { |team_user|
    team_user.incorporated_at = DateTime.now
    team_user.save
  }

  team3.users << owner
  ActiveRecord::Migration.say("#{owner.name} added to #{team3.name}")

  team4.users << owner
  ActiveRecord::Migration.say("#{owner.name} added to #{team4.name}")

  team5.users << owner
  ActiveRecord::Migration.say("#{owner.name} added to #{team5.name}")

  # Creating Tracks for this project
  track_values = [
    {
      name: 'Track test 1',
      description: 'Is a example',
      user: owner,
      project: project1,
      team: team1,
      status: :in_progress
    },
    {
      name: 'Track test 2',
      description: 'Is a example',
      status: :finished,
      user: user_one,
      project: project1,
      team: team1,
    },
    {
      name: 'Track test 3',
      description: 'Is a example',
      status: :finished,
      project: project1,
      team: team1,
      user: owner,
    },
    {
      name: 'Track test 4',
      description: 'Is a example',
      user: user_one,
      project: project1,
      team: team1,
      status: :finished
    },
    {
      name: 'Track test 5',
      description: 'Is a example',
      project: project1,
      team: team2,
      status: :in_progress,
      user: user_two
    },
    {
        name: 'Track test 6',
        description: 'Is a example',
        project: project1,
        team: team2,
        status: :finished,
        user: user_two
    },
    {
        name: 'Track test 7',
        description: 'Is a example',
        user: owner,
        project: project2,
        status: :finished,
        team: team2,
    },
    {
        name: 'Track test 8',
        description: 'Is a example',
        user: owner,
        project: project2,
        status: :in_progress,
        team: team2
    },
    {
        name: 'Track test 9',
        description: 'Is a example',
        user: user_one,
        project: project2,
        status: :in_progress,
        team: team1,
    },
    {
        name: 'Track test 10',
        description: 'Is a example',
        user: user_three,
        project: project2,
        team: team2,
        status: :finished
    },
    {
        name: 'Track test 11',
        description: 'Is a example',
        user: user_three,
        project: project2,
        team: team2,
    }
  ]

  track_values.each_with_index do |t, index|
    t = Track.create(t)
    ActiveRecord::Migration.say(
      "[#{index}] Creating track: #{t.name} to #{t.user.name} in Team #{t.team.name}: #{t.persisted?}")
  end


  # Creating intervals for tracks
  t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11 = Track.all

  t1_intervals = [
    {
      description: "this is a description of the interval",
      user: owner,
      start_at: datetime - 4.month,
      end_at: (datetime - 4.month) + 60.minutes
    },
    {
      description: "this is a description of the interval1",
      user: owner,
      start_at: datetime - 3.month,
      end_at: (datetime - 3.month) + 30.minutes
    },
    {
      description: "this is a description of the interval2",
      user: owner,
      start_at: datetime - 2.month,
      end_at: (datetime - 2.month) + 10.minutes
    },
    {
      description: "this is a description of the interval3",
      user: owner,
      start_at: datetime - 1.month,
      end_at: (datetime - 1.month) + 25.minutes
    },
    {
      description: "this is a description of the interval4",
      user: owner,
      start_at: datetime - 4.month,
      end_at: (datetime - 4.month) + 50.minutes
    }
  ]

  t1_intervals.each_with_index do |interval, index|
    i = t1.intervals.create(interval)
    ActiveRecord::Migration.say("[#{index}] Adding #{i.send(:calculate_minutes)} to #{i.track.name}: #{i.persisted?}")
  end

  i_t2 = t2.intervals.create({
    description: "whole",
    user: user_two,
    start_at: datetime - 2.month,
    end_at: (datetime - 2.month) + 10.minutes
  })
  ActiveRecord::Migration.say(
    "Adding #{i_t2.send(:calculate_minutes)} to #{i_t2.track.name}: #{i_t2.persisted?}")

  t3_intervals =[
    {
      description: "this is a description of the interval5",
      user: user_one,
      start_at: datetime - 4.month,
      end_at: (datetime - 4.month) + 30.minutes
    },
    {
      description: "this is a description of the interval6",
      user: user_one,
      start_at: datetime - 3.month,
      end_at: (datetime - 3.month) + 20.minutes
    },
    {
      description: "this is a description of the interval7",
      user: user_one,
      start_at: datetime - 2.month,
      end_at: (datetime - 2.month) + 10.minutes
    }
  ]

  t3_intervals.each_with_index do |interval, index|
    i = t3.intervals.create(interval)
    ActiveRecord::Migration.say("[#{index}] Adding #{i.send(:calculate_minutes)} to #{i.track.name}: #{i.persisted?}")
  end

  t5_intervals =[
    {
      description: "this is a description of the interval8",
      user: user_two,
      start_at: datetime - 4.month,
      end_at: (datetime - 4.month) + 10.minutes
    },
    {
      description: "this is a description of the interval9",
      user: user_two,
      start_at: datetime - 3.month,
      end_at: (datetime - 3.month) + 35.minutes
    },
    {
      description: "this is a description of the interval10",
      user: user_two,
      start_at: datetime - 2.month,
      end_at: (datetime - 2.month) + 15.minutes
    }
  ]

  t5_intervals.each_with_index do |interval, index|
    i = t5.intervals.create(interval)
    ActiveRecord::Migration.say("[#{index}] Adding #{i.send(:calculate_minutes)} to #{i.track.name}: #{i.persisted?}")
  end

  t8_intervals =[
    {
      description: "this is a description of the interval11",
      user: owner,
      start_at: datetime - 4.month,
      end_at: (datetime - 4.month) + 20.minutes
    },
    {
      description: "this is a description of the interval12",
      user: owner,
      start_at: datetime - 3.month,
      end_at: (datetime - 3.month) + 30.minutes
    },
    {
      description: "this is a description of the interval13",
      user: owner,
      start_at: datetime - 2.month,
      end_at: (datetime - 2.month) + 25.minutes
    }
  ]

  t8_intervals.each_with_index do |interval, index|
    i = t8.intervals.create(interval)
    ActiveRecord::Migration.say("[#{index}] Adding #{i.send(:calculate_minutes)} to #{i.track.name}: #{i.persisted?}")
  end

  t9_intervals =[
    {
      description: "this is a description of the interval14",
      user: user_one,
      start_at: datetime - 4.month,
      end_at: (datetime - 4.month) + 30.minutes
    },
    {
      description: "this is a description of the interval15",
      user: user_one,
      start_at: datetime - 3.month,
      end_at: (datetime - 3.month) + 15.minutes
    },
    {
      description: "this is a description of the interval16",
      user: user_one,
      start_at: datetime - 2.month,
      end_at: (datetime - 2.month) + 35.minutes
    }
  ]

  t9_intervals.each_with_index do |interval, index|
    i = t9.intervals.create(interval)
    ActiveRecord::Migration.say("[#{index}] Adding #{i.send(:calculate_minutes)} to #{i.track.name}: #{i.persisted?}")
  end
end
