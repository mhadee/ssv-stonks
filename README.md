# README

## The projet does the following
  * Allow user to sign in with git
  * Allow user to type favorite streamer
  * On the main page 3 colomns show; stream, chat, events (follow - done with web sockets)
  * For events I have handled only follow for now due to time constraints
  * Session management. Session expires after 7 days


## Questions 

#### How would you deploy the above on AWS?
  Would need to install the following:
   * Rails
   * Nginx
   * Redis  
  
  Redis is to run background jobs using sidekiq. Herokus free reddis isn't any good for it.
    

#### Where do you see bottlenecks in your proposed architecture and how would you approach scaling this app starting from 100 reqs/day to 900MM reqs/day over 6 months?
  The free server is the bottleneck. With a decent server and low traffic this will run smoothly.
  
### To do 900MM reqs/day 
  We would need the following steps and considerations among others:
    * Configure nginx to serve different app instances deployed on various servers as required
    * Create standalone service for any function we can seperate if needed
    * Seperate the database to a seperate server
    * Run db on multiple servers with db master slave replication to maintain consistency
    * Use caching for user sessions etc.
    * Smart querying; don't repeat calls for one streamer for different users
    * Use Pg bouncer for timeouts
    * Data insertions in bulk
    * Indexing
    * Query optimisation
    
    
#### Total number of events received by each streamer
`SELECT COUNT(*) AS count_all, streamer_name AS event_streamer_name FROM events GROUP_BY streamer_name`

#### Count of events by event_type and streamer name
`SELECT COUNT(*) AS count_all, event_type AS events_event_type, streamer_name AS events_streamer_name FROM events GROUP_BY event_type, streamer_name`
 
## Missing stuff
  - Other events; this is pretty straight-forward. The plan would be to fetch events with background jobs every X mins and display above - not pursued due to time constraints and heroku free tier redis issue
  
