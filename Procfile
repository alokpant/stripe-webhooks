web: bin/rails server -p 3000
js: yarn build --watch
css: yarn build:css --watch
stripe: stripe listen --forward-to localhost:3000/webhooks/stripe -c localhost:3000/webhooks
jobs: QUEUE=* rake resque:work