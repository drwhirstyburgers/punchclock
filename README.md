# punchclock

I will use user stories to work through each feature:

1. As a user I want to be able to log into my own personal punchclock
  - I considered using Devise, but anytime I have tried to modify devise it turns into a headache, so for simplicities sake I will build from the ground up.
  - The teacher model will need certain attributes, a name, an email, and a password.
    - The password will need to be encrypted, I will use the bcrypt gem for this because I have used it before and am familiar with how it works.
  - I started with the teacher login because once I have sessions set up I can scope the shift events to that teacher. It just seems straightforward to me this way.
  - I will add some validations to the Teacher model to make sure that people can't accidentally enter empty fields, I will also make sure that the email is unique so that people don't create multiple accounts.
    - the email will need to be made downcase from the user model so I can prevent problems arising from case sensitivity.
  - I use Ruby's has_secure_password. has_secure_password "adds methods to set and authenticate against a BCrypt password. This mechanism requires you to have a password_digest attribute". This function abstracts away much of the complexity of obfuscating user passwords using hashing algorithms which we would otherwise be inclined to write to securely save passwords. has_secure_password requires a password_digest attribute on the model it is applied to. has_secure_password creates two virtual attributes, password and password_confirmation that we use to set and save the password.
