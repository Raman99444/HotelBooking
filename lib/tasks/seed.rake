namespace :db do
  desc "Seed the database with initial data"
  task seed: :environment do
    puts "Seeding hotels..."
    Hotel.create!([
      { name: 'Hotel One' },
      { name: 'Hotel Two' },
      { name: 'Hotel Three' },
      { name: 'Hotel Four' },
      { name: 'Hotel Five' },
      { name: 'Hotel Six' },
      { name: 'Hotel Seven' },
      { name: 'Hotel Eight' },
      { name: 'Hotel Nine' },
      { name: 'Hotel Ten' }
    ])
    puts "Seeding completed!"
  end
end
