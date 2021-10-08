# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  { username: 'Malachi'},
  { username: 'Nick'},
  { username: 'Jack'},
  { username: 'Jane'}
])

Artwork.create([
  {title: 'sick artwork', artist_id: 1, image_url: 'monalisa.com'},
  {title: 'other artwork', artist_id: 2, image_url: 'someplace.com'},
  {title: 'art', artist_id: 2, image_url: 'something.com'}
])

ArtworkShare.create ([
  { viewer_id: 1, artwork_id: 2}, #Malachi - Views Nick1
  { viewer_id: 2, artwork_id: 1}, #Nick - views malachi
  { viewer_id: 3, artwork_id: 2}, #Jack - Views Nick1
  { viewer_id: 4, artwork_id: 1}  #Jane - views malachi
])

Comment.create([
  { author_id: 1, artwork_id: 2, body: "this is great1!"}, #Malachi - comments Nick1
  { author_id: 1, artwork_id: 3, body: "this is great2!"}, #Malachi - comments Nick2
  { author_id: 2, artwork_id: 2, body: "this is sick1!"}, #Nick - comments Nick1
  { author_id: 2, artwork_id: 2, body: "this is sick2!"} #Nick - comments Nick1
])

Like.create([
  { liker_id: 1, likable_id: 1, likable_type: "Artwork"},
  { liker_id: 1, likable_id: 2, likable_type: "Artwork"},
  { liker_id: 2, likable_id: 3, likable_type: "Artwork"},
  { liker_id: 2, likable_id: 1, likable_type: "Comment"},
  { liker_id: 2, likable_id: 2, likable_type: "Comment"}
])