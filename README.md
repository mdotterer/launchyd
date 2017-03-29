# launchyd
A daemon service for watching a directory and opening the contents with launchy

## Using launchy with Docker
If you are running Docker for development you can use launchyd to support `save_and_open_page` in Capybara as follows:

1. Configure a no-op for `BROWSER` in your docker container:
  In your Dockerfile:
  ```
    ENV BROWSER "cat '%s' > /dev/null"
  ```
2. Watch capybara's tmp folder with launchyd from your host:
  ``` bash
    launchyd ~/PATH/TO/MY/APP/tmp/capybara/
  ```
3. Use `save_and_open_page` to your hearts content! :tada:

### But how does it work?
When you use `save_and_open_page` Capybara first saves the html to a tmp directory. If you are using Docker for development, 
this file will also appear on your host. Under a conventional dev environment, the next step is for Capybara to call launchy 
to open the file using the contents of the `BROWSER` environment variable. Instead, the launchyd daemon runs on the host and
watches the directory and opens up any new files that appear.

### Can I use it with Heroku?
Nope, sorry. This setup relies on the shared docker volume between the host and the container.
