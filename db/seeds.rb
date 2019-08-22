# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

images = [
  { link: 'https://picsum.photos/id/261/200/300' },
  { link: 'https://picsum.photos/id/369/200/300' },
  { link: 'https://picsum.photos/200' },
  { link: 'https://picsum.photos/200' },
  { link: 'https://picsum.photos/id/1082/200/300' },
  { link: 'https://picsum.photos/id/210/200/300' },
  { link: 'https://picsum.photos/id/211/200/300' },
  { link: 'https://picsum.photos/id/212/200/300' },
  { link: 'https://picsum.photos/id/213/200/300' },
  { link: 'https://picsum.photos/id/214/200/300' },
  { link: 'https://picsum.photos/id/215/200/300' },
  { link: 'https://picsum.photos/id/216/200/300' },
  { link: 'https://picsum.photos/id/217/200/300' },
  { link: 'https://picsum.photos/id/218/200/300' },
  { link: 'https://picsum.photos/id/219/200/300' },
  { link: 'https://picsum.photos/id/240/200/300' },
  { link: 'https://picsum.photos/id/230/200/300' },
  { link: 'https://picsum.photos/id/220/200/300' },
  { link: 'https://picsum.photos/id/260/200/300' },
  { link: 'https://picsum.photos/id/270/200/300' },
  { link: 'https://picsum.photos/id/290/200/300' }
]

Image.create!(images)
