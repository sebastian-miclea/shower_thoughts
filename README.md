# Shower Thoughts
## Setup
Install dependencies:

    bundle

You first need to setup the database and create a client:

    rake db:setup

##  Running
Start the rails server

    rails s
With the server running you need to make a POST call to **refresh_token/[client_id]** with the ID you received when setting up the database

After you have a valid token, you can create calls to 
- GET **/thoughts** to get latest shower thoughts
- PATCH **/thoughts** to force update the thoughts

