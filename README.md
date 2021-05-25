# Camelan is a demo pets bids app

## Make it work !

* Good news! the project is dockerized so count to 3 and this section will be done
* After forking the repo, run `docker-compose up --build`
* When the server is up and running use [localhost:3000](http://localhost:3000) to check that everything looks good
* [**API DOCUMENTATION**](http://localhost:3000/api-docs) if you are not familiar with Swagger Api Documentation (hopefully you are because this [Introductory video](https://www.youtube.com/watch?v=7MS1Z_1c5CU) is 10 mins long :) )

* running the tests using `docker-compose exec  camelan rspec`
## Technical Details 

1) starting the docker compose will create around 20 records of each [pets, users ,bids] so when you test from swagger, you can easily start by user_id = 1 , pet_id = 1
 
2) Requirements are all covered with test cases found in the spec folder

## Environment

* Ruby
* Rails
