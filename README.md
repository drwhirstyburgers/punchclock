# punchclock

## I have created a Heroku app [here](https://davidspunchclock.herokuapp.com/)

I will use user stories to work through each feature:

1. As a user I want to be able to create an account.
  - I considered using Devise, but anytime I have tried to modify devise it turns into a headache, so for simplicities sake I will build from the ground up.
  - The teacher model will need certain attributes, a name, an email, a password. and a working:boolean.
    - The password will need to be encrypted, I will use the bcrypt gem for this because I have used it before and am familiar with how it works.
    - the working boolean will be useful for setting up conditionals later to check if a teacher is already working so they can't punch in twice. It will be default to false because they wont be teaching.
  - I started with the teacher login because once I have sessions set up I can scope the shift events to that teacher. It just seems straightforward to me this way.
  - I will add some validations to the Teacher model to make sure that people can't accidentally enter empty fields, I will also make sure that the email is unique so that people don't create multiple accounts.
    - the email will need to be made downcase from the user model so I can prevent problems arising from case sensitivity.
  - I use Ruby's has_secure_password. has_secure_password "adds methods to set and authenticate against a BCrypt password. This mechanism requires you to have a password_digest attribute". This function abstracts away much of the complexity of obfuscating user passwords using hashing algorithms which we would otherwise be inclined to write to securely save passwords. has_secure_password requires a password_digest attribute on the model it is applied to. has_secure_password creates two virtual attributes, password and password_confirmation that we use to set and save the password.
  - I will now need to set up routes, as I will only need new and create I will use the only qualifier.
  - next I will need a teachers controller so I can manage the information from the server to the UI.
  - I will need a new method and create methods
  - to simplify and make the code DRY I will use a private function to pass the correct params to the create method.
  - I thought that since there are validations, I would build a helper method to display what the expectations are if they are violated in the form in the view.

2. As a user I want to be able to sign in into my account using my email
  - I will need a sessions controller in order to do this.
  - the sessions controller will need new, create and destroy methods.
    - the new method requires nothing
    - the create method will assign a teacher variable where it will find a teacher by their email and downcase it. It will then check if the email and username are correct and then start the create_session method also to be written as a helper method.
    - the destroy method will implement some wishful coding with a destroy_session helper method I will write in a minute
  - I will need some helper methods:
    - I define create_session. create_session sets user_id on the session object to  teacher.id, which is unique for each teacher. session is an object Rails provides to track the state of a particular user. There is a one-to-one relationship between session objects and user ids. A one-to-one relationship means that a session object can only have one user id and a user id is related to one session object.
    -  I define destroy_session. I clear the teacher id on the session object by setting it to nil, which effectively destroys the teacher session because we can't track it via their id any longer.
    - I define current_teacher, which returns the current teacher of the application.  current_user encapsulates the pattern of finding the current user that we would otherwise call throughout punchclock. Thus we won't have to constantly call  Teacher.find_by(id: session[:teacher_id]); current_teacher is our shortcut to that functionality.
  - SessionsController has no way of finding create_session - it won't recognize it as a valid method. I need to include SessionsHelper either directly in SessionsController, or in ApplicationController (which SessionsController inherits from). I will add it to  ApplicationController, since I'll need to use it in other controllers later.
  - I need to add sessions to the routes.
  - I need to create the sign-in view.

3. As a user I want to be able to punch into my shifts
  - First I will need a shifts model. I considered making a punchin and punchout model but I can't see any advantage to this other than making the relationships between objects more complex. As such I just have shift model in belongs_to has_many relationship with the teacher model. This will allow teachers to have many log ins making analysis and analytics easier for future features, rather than just updating the same attribute each shift.
  - I have these attributes clock_in:timestamp clock_out:timestamp date:timestamp. the first two are obvious. The date will be useful later for defining what days the shift were worked so I can scope pay periods and display that information later.
  - I will have the shifts migration file reference a teacher
  - I have set the default value of date to Date.today so it will just do it as soon as one is created.
  - add belongs_to and has_many to the respective models
  - I need a shifts controller with an index, new, create and edit
    - the index will show the current shift and the past worked shifts and any other information
    - new/create will be to punch in
    - edit will be to punch out
  - the index will need to be scoped to the current teacher so I will use the current_teacher method i created earlier
  - The new will just be a page with a clock in button that updates the clock_in time
  - create will need to call a method that updates the working attribute to true on the currrent teacher. It will be defined in the teacher model and called in the shifts controller.
  - I need to create a conditional in application.html.erb so if the person is currently working they dont have the option to clock in

4, As a user I want to be able to clock out
  - I used the update method because I was unable to find a way to call a method from the index view or with a button in the navbar that would just clock out and update all the attributes that are necessary. I will spend more time on this another time.
  - I used conditionals to update the views based on whether or not someone is logged in.

5. As a user I want an index of shifts worked and the one I am currently working.
  - I have updated the index with conditionals to display whether the current teacher is working with an option to clock out from there if they are.
  - otherwise it only displays the shifts worked scoped to the current teacher as per the controller.
  - I recycled my hours worked method and attached it to this app so the user can see how long their shift was,

## Future considerations

6. As a user I would like to know how many hours I worked in a pay period
  - I could use the dates to figure this out somehow.

7. As an administrator I would like to see hours worked according to employees
  - create a teachers index that would authenticate the role of the user_id
  - each teacher would be a link that would have a list of the shifts they have worked.

  ## Continuing work

  1. As a developer I want to make sure that someone can't punch in while they are already working.
    - I added a conditional to the create function that asks whether the current teacher is working. That way, if someone hits back and ends up on the clock in page they can't clock in twice.

  2. As a developer I want to make sure that people are redirected to the sign in page if they try to access a page they don't have access to.
    - I will make a require_sign_in method that redirects user to the sign in page if they somehow try and get to a page they dont have access. I will make it a private method in the applpication controller so it is accessible throughout the application.
    - I noticed that when I tried to come back to the heroku app after I had left it inactive I would get an error message because the session had ended but the browser was trying to render the last page I had been on.
    - I will trigger the method in the before action on the shifts controller.

  3. As a developer I want to utilize enumerators to determine whether the teacher is working.
    - Updating the boolean from a method was proving rather challenging so I switched to the enumerator method. It also offers a little more dynamism in terms of calling it in conditionals.

  4. As a user I want to see my most recent shifts first.
    - I will just quickly add "default_scope { order('created_at DESC') }" to the shift model to make it more intuitive.

  5. As a developer I want to be able to call the update and create method from the index in order to avoid unnecessary clicks.
    - This is proving most challenging for me. I will consult a to do app I created wherein the to-dos were created from the users new view.
    - so far I have tried using helper methods, but I had trouble passing the object to the method.
    - I am pretty sure I have to manipulate the routes to modify the AJAX requests accordingly.
    - I managed to do it by manipulating the routes to match to the action in the controller and passing the correct data to the forms via the controller and each loops.

## Future considerations:

1. As a user I would like to see how many hours I worked in the last pay period.

2. As a user I want to see how much money I made in the past pay period.


I have worked hard on this. I hope it shows what I am capable of.
