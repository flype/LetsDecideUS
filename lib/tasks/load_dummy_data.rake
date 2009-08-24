namespace :db do

  desc "Reload in the database some  date generated with factories." 
  task :load_dummy_data => :environment do 
    5.times do 
      question = Factory(:question, 
      :body => "niesta, está en la mancha:
               http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=iniesta&sll=37.0625,-95.677068&sspn=41.682395,86.923828&ie=UTF8&z=11&iwloc=A
               
               Ahi van unos cuantos videos con cositas sobre el pueblo:
               
               Estos son mis padres, mira que majos y como sonrien a la camara, :D
               http://www.youtube.com/watch?v=XopEejnNKZo
               
               Hay muchas tradiciones:
               http://www.youtube.com/watch?v=wTxB0WEmeic
               
               hay hasta street art!
               http://www.flickr.com/photos/flype/240328288/in/set-72157600052667031/
               
               Ale animaros!")
      rand(20).times { 
        case rand(3)
          when 0: Factory(:answer, :question => question, :created_at => Time.local( Time.now.year, Time.now.month, (rand(Time.now.day)+1) ), :vote => "-1", :body =>"-1\n\n paso de esa mierda, ni de coña!", :mail =>"felipe.talavera@gmail.com", :name => "Felipe Talavera")        
          when 1: Factory(:answer, :question => question, :mail =>"fguillen.mail@gmail.com", :name => "Fernando Guillen", :created_at => Time.local( Time.now.year, Time.now.month, (rand(Time.now.day)+1) ), :vote => "+1", :body =>"+1\n\n paso de esa mierda, ni de coña!")
          when 2: Factory(:answer, :question => question, :mail =>"voodoorai2000@gmail.com", :name => "Raimon Garcia", :created_at => Time.local( Time.now.year, Time.now.month, (rand(Time.now.day)+1) ), :vote => "-1", :body =>"-1\n\n paso de esa mierda, ni de coña!")
        end
        }
    end
    puts "db llena de datos"
  end 

  desc 'Drops, creates, migrates & load_dummy_data.'
  task :remake => [:drop, :create, :migrate, :load_dummy_data]

end