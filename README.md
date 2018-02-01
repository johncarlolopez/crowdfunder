![Bitmaker](https://github.com/johncarlolopez/bitmaker-reference/blob/master/bitmakerlogo.svg)
# Test Driven Development: Crowdfunder
### Friday, Jan 26th


[See assignment in Alexa.](https://alexa.bitmaker.co/wdi/may-2017/assignments/2393/latest)

For our last Rails app we are starting you off with a functioning crowdfunding app. Your job will be to work with this existing code base and implement some advanced features. We have given you a list of user stories to choose from, although you are also welcome to add ideas of your own.

### Learning Objectives
___
  * Test-first development
  * To get a feel for what it is like to work on a real project
  * To get experience working in an existing code base that you didn't write yourself
  * Gain some experience working in groups on a software project
  * To learn how to prioritize user stories
### Setup
___
1. One group member should fork this repository into their account
2. Add other group members as collaborators
3. Clone the repository to your local machine
4. Make sure Postgres is running
5. Run bundle install (This project uses PostgreSQL, it must be running first!)
6. Run rails db:setup
7. Try running the test suite by running rake. There should be exactly 4 tests failing.  

Your project should now be ready for you to start work on, complete with seed data in the database.

Once the app is running, take a few minutes to try out signing up, creating a project, backing a project, and generally familiarizing yourself with how it works. You should also take some time to browse through the existing code: check out the schema, routes, Gemfile, and anything else you're curious about.

### Warm-up: Making the Failing Tests Pass
___
Your first task is to write the code to make the failing tests pass.

The four failing tests are:

In project_test.rb: test_project_is_invalid_without_owner
In pledge_test.rb: test_owner_cannot_back_own_project
In reward_test.rb:  
  test_A_reward_cannot_be_created_without_a_description
  test_A_reward_cannot_be_created_without_a_dollar_amount

### Fix one of the failing tests
___
First fix the test_project_is_invalid_without_owner failing test. Do this by not changing the best, but rather adding a validation to the project model that checks for an owner.

### Fix the remaining failing tests of the failing tests
___
Add code to the necessary models to fix the other three failing tests.

## Reflect and Tread Carefully ...
___
Once all the tests are passing, your code is considered "green". As a programmer, this is wonderful place to be.

Going forward, try not to go "red" for too long (i.e. tests are failing).

If you continue coding and tests begin to fail, back-out of your change until your tests are passing again and then take a different approach.

It's best practice to not commit code when tests are failing.

## Freedom
___
Now that all the tests are passing again, your next task is to read through the following collection of user stories as a team and decide which ones you want to prioritize and how you will divide them among yourselves (we recommend pairing). There are far more stories to choose from than you would be able to finish in the time given, so your group can decide to work on the ones that are most interesting to you.

For each story you decide to implement, first determine whether it requires a unit test: a good guideline for deciding this is to think about whether you're going to be adding any code to your models. If you are, then you should also have new test code to go with those changes. If you're working purely in the views and controllers, you probably don't need to write a test. But remember that calculations/logic should be kept in model methods. When in doubt, consult with an instructor before proceeding!

If the story you're working on does involve adding code to the models, you should start by writing a single failing test, then implement the feature, and then add a few more tests to ensure full coverage of the feature (think about positive/success cases, negative/failure cases, and edge cases).

Good luck!

## User Stories
___
### Validations
___
  * **(Complete)** dollar_amount should be a required field for pledges
  * **(Complete)** Project start date must be in future
  * **(Complete)** Project end date must be later than start date
  * **(Complete)** A project's goal must be positive number
  * **(Complete)** Reward dollar_amount must be positive number
  * **(Complete)** Add error messages to the project, pledge, sign up, and login forms so that if any validations fail the user can see what went wrong
### Accounts
___
  * **(Complete)** As a user I should be able to visit my profile page and see a list of all the projects I have backed, the total amount I have pledged on the site, and a list of all the projects I own
  * **(Complete)** As a user, when I go to a project’s page, I should be able to see who the project’s owner is and follow a link to their profile page to see what other projects they own and have backed
### Project page
___
  * **(Complete)** As a user, when I go to a project’s page, I should see how much money has been pledged so far
  * **(Complete)** As a user, when I go to a project’s page, it should tell me if I have already backed that project or not
  * **(Complete)** As a user, when I go to a project’s page, it should tell me how much time is left until the funding deadline (like it does on the project index currently)
### Project owners
___
  * **(Complete)** As a project owner, when I go to my project’s page, I should see a list of who has backed my project
  * **(Complete)** As a project owner, when I go to my project’s page, I should see a summary of how many rewards have been claimed
  * **(Complete)** As a project owner, when I create a new project, I should have the option of setting a limit for how many times a specific reward can be claimed
  * **(Complete)** As a project owner I should be able to post updates on the progress of my project.
  * **(Complete)** As a backer, when I go to the page of a project I have backed, I should see all the updates from the owner in reverse chronological order
  * **(Complete)** As a user, when I go to the page of a fully funded project that is past its deadline that I have not backed, I should only see updates about that project from before the funding deadline. Updates for funded projects that were made after funding ended are for backers’ (and the owner’s) eyes only.
  * **(Complete)** As a backer I should be able to leave a comment on a project I have backed
### Categories
___
  * **(Complete)** Add a category model (eg. technology, art) and the ability to create a project under a specific category
  * **(Complete)** Users should be able to browse projects by category
### Homepage
___
  * **(Complete)** Create a home page for the app that shows a summary of how many projects have been started, how many have been funded, how much money has been pledged towards successful projects in total
### Search
___
  * **(Complete)** As a user I want to be able to search for projects by name


## Our To-do list

* **(Complete)** Make a default image when project is created if image field is empty
* **(Complete)** Seperate Rewards and Comments Sections
* **(Complete)** Transfer projects controller methods into model methods -> Then test them
* **(Complete)** Create my profile in the nav
* As a non-project owner I shouldn't be able to make/remove rewards
* **(Complete)** Make a validation so that you cannot pledge to a project past it's deadline
* **(Complete)** As a backer I should be able to make a comment on a project I have backed
* **(Complete)** Make logo link to homepage not projects#index


## Resources
___
  [A Guide to Testing Rails Applications](http://guides.rubyonrails.org/testing.html)

  [Minitest Docs](http://docs.seattlerb.org/minitest/)
