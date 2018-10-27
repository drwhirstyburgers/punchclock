# punchclock

I will use user stories to work through each feature:

1. As a user I want to be able to create an account.
  - I considered using Devise, but anytime I have tried to modify devise it turns into a headache, so for simplicities sake I will build from the ground up.
  - The teacher model will need certain attributes, a name, an email, and a password.
    - The password will need to be encrypted, I will use the bcrypt gem for this because I have used it before and am familiar with how it works.
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
  
