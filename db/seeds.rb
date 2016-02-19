# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
  users = User.create([{ name: 'One', email: "ss@ss.ss", password: "ss" },
      { name: 'Two', email: "ss1@ss.ss", password: "ss" },
      { name: 'Three', email: "ss2@ss.ss", password: "ss" },
      { name: 'Four', email: "ss3@ss.ss", password: "ss" },
      { name: 'Five', email: "ss4@ss.ss", password: "ss"}])
  Friendship.create([{from_id: users[0].id, to_id: users[2].id, accepted: false},
      {from_id: users[0].id, to_id: users[1].id, accepted: true},
      {from_id: users[3].id, to_id: users[0].id, accepted: true},
      {from_id: users[4].id, to_id: users[0].id, accepted: false}])
