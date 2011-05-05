namespace :app do
    # rake app:create
    desc 'create basic data for application'
    task :create => ['db:drop', 'db:create', 'db:migrate', 'db:pages:create']
end

namespace :db do
  namespace :pages do

    n = 5 # make n*n*n nodes
    
    desc 'create test pages for users'
    # rake db:pages:create
    task :create => :environment do
      puts 'Pages creating'
        x = 1
        n.times do |i|
          page= Page.new
          page.title= "level 1, elem #{i} | " + Faker::Lorem.sentence(3)
          page.content= Faker::Lorem.sentence(30)
          page.save
          puts 'page --'
          x=x.next
          puts x

          if [true, false].shuffle.first
            n.times do |j|
              _page= Page.new
              _page.title= "level 2, elem #{j} | " + Faker::Lorem.sentence(3)
              _page.content= Faker::Lorem.sentence(30)
              _page.save
              _page.move_to_child_of(page)
              puts 'page -- --'
              x=x.next
              puts x

              if [true, false].shuffle.first
                n.times do |k|
                  __page= Page.new
                  __page.title= "level 3, elem #{k} | " + Faker::Lorem.sentence(3)
                  __page.content= Faker::Lorem.sentence(30)
                  __page.save
                  __page.move_to_child_of(_page)
                  puts 'page -- -- --'
                  x=x.next
                  puts x
                end# n.times do
              end# [true, false].shuffle.first

            end# n.times do
          end# [true, false].shuffle.first   

        end# n.times do

      puts 'Pages created'
    end# db:pages:pages
  end#:pages
end#:db
