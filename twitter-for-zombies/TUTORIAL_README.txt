$ rails console


# Retrieve a tweet with id = 3

1.9.3p194 :011 > t = Tweet.find(3)
  Tweet Load (0.6ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`id` = 3 LIMIT 1
 => #<Tweet id: 3, status: "I just ate some delicious brains", zombie_id: 3, created_at: "2012-10-05 06:27:37", updated_at: "2012-10-05 06:27:37"> 
1.9.3p194 :012 > puts t[:id]
3
 => nil 
1.9.3p194 :013 > puts t[:status]
I just ate some delicious brains
 => nil 
1.9.3p194 :014 > puts t[:zombie]

 => nil 
1.9.3p194 :015 > puts t[:zombie_id]
3
 => nil 

# Alternate syntax = 
puts t.id
puts t.status
puts t.zombie_id


# Getting the name of the Zombie =
Zombie.find(t.zombie_id).name
 => "Jim" 


######################
        CRUD
######################

# Create
Tweet.create(:status => "My left arm is missing but I don't care", :zombie_id => 2)

# Read
Tweet.find(3)

# Update
t = Tweet.find(3)
t.update_attributes(:status = "I <3 brains a lot!")

# Delete
Tweet.find(3).destroy

#######################


# Alternate functions


# Create

t = Tweet.create(:zombie_id => 2)
t.errors  will return a hash of validation error



# Read
Tweet.find(2,3)
Tweet.first
Tweet.last
Tweet.all
Tweet.count
Tweet.order(:zombie_id)
Tweet.limit(10)       # Return only top 10 tweets
Tweet.where(:zombie_id => 1)      # Find all tweets for zombie with id = 3

Tweet.where(:zombie_id => 1).order(:status).limit(3)      # Method chaining


# Destroy

Tweet.destroy_all


#######################
    VALIDATION
#######################

   
validates :status, :presence => true, :length => { :minimum => 3 }

    :presence => true
    :uniqueness => true
    :numericality => true
    :length => { :minimum => 0, :maximum => 2000 }
    :format => { :with => /.*/ }
    :inclusion => { :in => [1,2,3] }
    :exclusion => { :in => [1,2,3] }
    :acceptance => true
    :confirmation => true


######################################
      NOTE - Peculiar Rails Syntax
######################################

NOTE: tweet table has zombie_id in it. But you can create a tweet by passing a zombie to it


mysql> describe tweets;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| id         | int(11)      | NO   | PRI | NULL    | auto_increment |
| status     | varchar(255) | YES  |     | NULL    |                |
| zombie_id  | int(11)      | YES  | MUL | NULL    |                |
| created_at | datetime     | NO   |     | NULL    |                |
| updated_at | datetime     | NO   |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
5 rows in set (0.01 sec)


mysql> describe zombies;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| id         | int(11)      | NO   | PRI | NULL    | auto_increment |
| name       | varchar(255) | YES  |     | NULL    |                |
| graveyard  | varchar(255) | YES  |     | NULL    |                |
| created_at | datetime     | NO   |     | NULL    |                |
| updated_at | datetime     | NO   |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
5 rows in set (0.01 sec)



# Create a Tweet by passing a :zombie object (not the zombie_id)

1.9.3p194 :001 > z = Zombie.find(3)
 => #<Zombie id: 3, name: "Jim", graveyard: "My Father’s Basement", created_at: "2012-09-09 06:00:48", updated_at: "2012-09-09 06:00:48"> 
1.9.3p194 :002 > Tweet.create(:status => "Testing this status", :zombie => z)
 => #<Tweet id: 6, status: "Testing this status", zombie_id: 3, created_at: "2012-10-05 06:54:38", updated_at: "2012-10-05 06:54:38">
 

# Get all tweets that belong to zombie z 
 
1.9.3p194 :005 > z.tweets
  => [#<Tweet id: 3, status: "I just ate some delicious brains", zombie_id: 3, created_at: "2012-10-05 06:27:37", updated_at: "2012-10-05 06:27:37">, #<Tweet id: 6, status: "Testing this status", zombie_id: 3, created_at: "2012-10-05 06:54:38", updated_at: "2012-10-05 06:54:38">]

# Getting the zombie who owns tweet 1

Tweet.find(1).zombie.name
=> "Ash"



#################################
  Ruby tags found in erb files
#################################

<% ... Evaluate ... %>
<% ... Evaluate and print ... %>


###################################
  Tags in application.layout.erb
###################################

# => 1

<%= stylesheet_link_tag :all %>

# Includes CSS files from:

    twitter-for-zombies
      -> public
        -> stylesheets

# Renders
  <link href="/stylesheets/scaffold.css" media="screen" rel="stylesheet" type="text/css" />



# => 2 

<%= javascript_include_tag :defaults %>

# Includes JS files from:

    twitter-for-zombies
      -> public
        -> javascripts

# Renders
  <script src="/javascripts/prototype.js" type="text/javascript"></script>
  


# => 3

  <%= csrf_meta_tag %>

# Renders
  <meta name="csrf-param" content="authenticity_token"/>
  <meta name="csrf-token" content="I+d..jI="/>

# These tags are used to prevent cross site request forgery. They are automatically added to each form in the application and are included in each request to prevent hacking



##################
    ROOT PATH
##################

http://ZombieTwitter.com/[something]

twitter-for-zombies
  -> public
    -> javascripts
    -> stylesheets
    -> images


When someone types the above URL rails will try to find that file in the public directory. If it exists, rails will render it. Else it will consider it as rails code and try to execute it.


##########################
    MAKE A ZOMBIE LINK
##########################

<%= link_to tweet.zombie.name, zombie_path(tweet.zombie) %>

OR SIMPLER

<%= link_to tweet.zombie.name, tweet.zombie %>


Will render:

    <a href="/zombies/1">Ash</a>


##############################
    SEARCHING SOURCE CODE
##############################

# 1: Clone the source and search
git clone http://github.com/rails/rails.git

# 2: api.rubyonrails.org
# 3: http://apidock.com/rails
# 4: http://railsapi.com/


########################################
    ITERATION  and  handling 0 tweets
########################################

<% tweets = Tweet.all %>
<% tweets.each do |tweet| %>
  <tr>
    <td><%= link_to tweet.status, tweet %></td>
    <td><%= link_to tweet.zombie.name, tweet.zombie %></td>
    <td><%= link_to "Edit", edit_tweet_path(tweet) %></td>
    <td><%= link_to "Delete", tweet, :method => :delete %></td>
  </tr>
<% end %>

<% if tweets.empty? %>
  <em>No tweets found</em>
<% end %>


##########################
      LINK_TO PATHS
##########################

 <%= link_to "<link text>", <code> %>
￼￼
Action            Code              The URL Generated
List all tweets   tweets_path       /tweets
New tweet form    new_tweet_path    /tweets/new
￼
tweet = Tweet.find(1)

Action            Code                        The URL Generated
Show a tweet      tweet                       /tweets/1
Edit a tweet      edit_tweet_path(tweet)      /tweets/1/edit
Delete a tweet    tweet, :method => :delete   /tweets/1



#########################
    REQUEST RESPONSE
#########################

Request -> Route -> Controller -> Model -> Controller -> View -> Route -> Response
  
#####################
    CONTROLLER
#####################

Every method in the controller maps to a view file with the same name

One of the best practices of Ruby is to keep all the model calls such as Tweet.find(1) inside the controller.

In a controller, you would use instance variables which would then be available to the view.

Example:

# Controller:

class TweetsController < ApplicationController
  def show
    @tweet = Tweet.find(1)
  end
end

# View:
<h1><%= @tweet.status %></h1>
<p>Posted by <%= @tweet.zombie.name %></p>


###################################
    Rendering non-default view
###################################

This will render a view called status instead of show: .../app/views/tweets/status.html.erb

# Controller

def show
  @tweet = Tweet.find(1)
  render :action => 'status'
end


##############################
    Reading Id from params
##############################

# This will read the id passed in the URL like:  .../tweets/5

@tweet = Tweet.find(params[:id])

# Query parameters sent in a URL or by POST action are stored in a params hash with the request

# Often in the param hash, there are multiple hashes as:

params = {:tweet => { :status => "I’m dead" }}

# You can still index the values of those params as:

@tweet = Tweet.create(:status => params[:tweet][:status])

# Since the above code passes a hash with the same key (:status) as found in the params to create(), the key can be automatically passed and this can also be written as:

@tweet = Tweet.create(params[:tweet])


################################
    Rendering other formats
################################

To render other formats like .../tweets/1.json   or  .../tweets/1.xml  for web services, add this to controller:

def show

  @tweet = Tweet.find(params[:id])

  respond_to do |format|
    format.html # show.html.erb
    format.xml  { render :xml @tweet }
    format.json { render json: @tweet }
  end

end



#####################################
    Common actions in controller
#####################################

def index		  List all tweets
def show	  	Show a single tweet
def new		    Show a new tweet form
def edit	  	Show an edit tweet form
def create		Create a new tweet
def update		Update a tweet
def destroy		Delete a tweet



###################################
    AUTHORIZATION using session
###################################

# session works like a per user hash often saved in a cookie

class TweetsController < ApplicationController

  def edit
  
    @tweet = Tweet.find(params[:id])
    
    if session[:zombie_id] != @tweet.zombie_id
      redirect_to(tweets_path, :notice => "Sorry, you can’t edit this tweet")      # Does a 501 redirect with a notice
      # OR  redirect_to   tweets_path, :notice => "Sorry, you can’t edit this tweet"
    end 
    
  end
end


The notice can be added to    .../layouts/application.html.erb    before the <%= yield %> statement as:

<% if flash[:notice] %>
  <div id="notice"><%= flash[:notice] %></div>
<% end %>



################################################
    Execute repeated code once in controller
################################################


# Use before_filter to execute common code across specified actions


class TweetsController < ApplicationController
   before_filter :get_tweet, :only => [:edit, :update, :destroy]
   before_filter :check_auth, :only => [:edit, :update, :destroy]

   def get_tweet
      @tweet = Tweet.find(params[:id])
   end
   
   def check_auth
      if session[:zombie_id] != @tweet.zombie_id
         redirect_to tweets_path, :notice => "Sorry, you can’t edit this tweet"
      end
   end

  def edit ... end
  def update ... end
  def destroy ... end
  
end
 


################
    ROUTING
################

RailsForZombies::Application.routes.draw do
    resources :tweets

This resources command creates a RESTful resource for tweets and thus automatically the actions defined in controller can be accessed by their various "RESTful" URLs.


To add a custom route, you can add:

match 'new_path_name' => "controller#action"

To use the route alias in a link_to tag, use:

match 'new_path_name' => "controller#action", :as => "my_new_path"

<%= link_to "All Tweets", my_new_path %>




########################
    URL Redirection
########################

# Redirecting   .../all     to    .../tweets
match 'all' => redirect('/tweets')

# Redirecting   .../google    to external site  .../www.google.com
match 'google' => redirect('http://www.google.com/')

# Route root path   .../    to  .../tweets
root :to => "Tweets#index"

# Using the root path in views:

<%= link_to "All Tweets", root_path %>



#########################
    ROUTE PARAMETERS
#########################


## EXAMPLE 1

# Suppose URLs have a zip code and you want to access them in your controller
/local_tweets/32828
/local_tweets/32801


# Route
match 'local_tweets/:zipcode' => 'Tweets#index', :as => 'local_tweets'


# Controller
def index
   if params[:zipcode]
     @tweets = Tweet.where(:zipcode => params[:zipcode])
   else
     @tweets = Tweet.all
   end
end   


# View
<%= link_to "Tweets in 32828", local_tweets_path(32828) %>



## EXAMPLE 2

# Twitter style access i.e. show all tweets of a zombie by his user name specified in the URL as:

.../Jim
.../Ash

# Route
match ':name' => 'Tweets#index', :as => 'zombie_tweets'

# View
<%= link_to "Ash", zombie_tweets_path('Ash') %>

# Contoller
def index
   if params[:name]
     @zombie = Zombie.where(:name => params[:name]).first
     @tweets = @zombie.tweets
   else
     @tweets = Tweet.all
   end
end






