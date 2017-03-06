# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create( first_name: "Ashley", last_name: "Hutton", email: "ashleyhutton119@gmail.com", password: "password")

Project.create( name: 'Cola', owner_id: User.first.id)
Project.create( name: 'TASN', owner_id: User.first.id)

Task.create( description: "Finish Sketch mockups", project_id: Project.first.id, owner_id: User.first.id, due_at: DateTime.now)
Task.create( description: "Email client for feedback", project_id: Project.first.id, owner_id: User.first.id, due_at: DateTime.now)
Task.create( description: "Give mysefl a pat on the back", project_id: Project.first.id, owner_id: User.first.id, due_at: DateTime.now)

Task.create( description: "Implement new feature", project_id: Project.last.id, owner_id: User.first.id, due_at: DateTime.now)
Task.create( description: "Fix the bug", project_id: Project.last.id, owner_id: User.first.id, due_at: DateTime.now)
Task.create( description: "Conference call with Sally", project_id: Project.last.id, owner_id: User.first.id, due_at: DateTime.now)


User.create( first_name: "Hannah", last_name: "Johnson", email: "hannah@gmail.com", password: "password")

Task.create( description: "Meet with Matt about designs", project_id: Project.first.id, owner_id: User.last.id, due_at: DateTime.now)
Task.create( description: "Finish work", project_id: Project.first.id, owner_id: User.last.id, due_at: DateTime.now)

Task.create( description: "Fix a very bad bug", project_id: Project.last.id, owner_id: User.last.id, due_at: DateTime.now)
Task.create( description: "Meet with Ashley about something", project_id: Project.last.id, owner_id: User.last.id, due_at: DateTime.now)
Task.create( description: "Finish the project", project_id: Project.last.id, owner_id: User.last.id, due_at: DateTime.now)