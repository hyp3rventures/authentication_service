# Hyper::AuthenticationService
Authentication service for the Hyp3r core API. 
Use this when you have an application that needs a full, authenticated user object.

## Usage

### ENV
Add `AUTHENTICATION_BASE` as an environment variable, e.g. 'https://app.hyp3r.co'

### Gemfile
`gem 'hyper-authentication_service', git: 'git@github.com:hyp3rventures/authentication_service'`

### Terminal
`$ bundle install`

### Code
```ruby
require 'hyper/authentication_service'

user_hash = { :email => 'user@example.com', :authentication_token => 'bzzz' }
service = Hyper::AuthenticationService::Request.new
service.run(user_hash)
authenticated_user = service.user
```

You also have access to the response object via `Request#response`.

## Contributing

* Follow the Code of Conduct
* Fork or clone the repo
* Create a new branch
* Write and test your code - code-related PRs with no tests will be rejected
* Create a PR

That's it, enjoy.

© 2017 Hyp3r, Inc
