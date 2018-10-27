# punchclock

I will use user stories to work through each feature:

1. As a user I want to be able to log into my own personal punchclock
  - I considered using Devise, but anytime I have tried to modify devise it turns into a headache, so for simplicities sake I will build from the ground up.
  - The teacher model will need certain attributes, a name, an email, and a password.
    - The password will need to be encrypted, I will use the bcrypt gem for this because I have used it before and am familiar with how it works.
