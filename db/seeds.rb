# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

raz = User.create!({:username => 'twerkzerker'})
adler = User.create!({:username => 'pornstar'})

Follow.create!({:stalker_id => adler.id, :prey_id => raz.id})

Status.create!({:body => "My milkshake brings all the boys in the yard.", :author_id => raz.id})
Status.create!({:body => "Damn right it's better than yours.", :author_id => raz.id})
Status.create!({:body => "It is a good day to die!", :author_id => adler.id})