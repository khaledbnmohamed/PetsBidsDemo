namespace :seed do
  desc 'create users and pets seed'
  task create_seeds: :environment do
    FactoryBot.create_list(:pet, 20)
    FactoryBot.create_list(:bid, 20)
  end
end
