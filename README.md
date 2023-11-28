# Getting started with Backend APP

To run the project:

Install dependencies and start server:

```
cd backend
bundle install
rake db:drop db:create db:migrate db:seed
```

Update credentials from root folder using:
```
EDITOR=vi rails credentials:edit
```
Sample of credentials:

```
stripe:
  development:
    public_key: pk_test
    private_key: sk_test
    signing_secret: whsec_
    publisher_key: pk_test_
    secret_key: sk_test_
  production:
    public_key:
    private_key:
    signing_secret:
    publisher_key:
    secret_key:
```

Run rails
```
./bin/dev
```
Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.


To run tests:
```
rails test
```
