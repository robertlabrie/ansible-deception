# The Ansible Deception

Is Ansbile purely declarative? I kept hearing about it's virtues, but it didn't make sense to me how something with loops, conditions, variable assignment and substitution, input/output -- how that could be "purely declarative" the way Kubernetes or Terraform is. I heard a few dissenting voices, which described it more like "programming in YAML". So I thought: "can you write an application in Ansible". The answer is: YES.

Ansible is not a purely declarative configuration management tool, it's an ad-hoc task runner in a category I call "barely imperative". To hit that point harder, I literally wrote a web app using Ansible as a general purpose language. If you're asking "why would you do that" -- instead ask yourself why you would do anything in Ansible: a terrible ad-hoc GPL implemented in YAML?

The `deception.rb` file is a Sinatra wrapper, which accepts HTTP requests, JSONifies them for Ansible, then passes the results back on to the UA. There is *zero application logic* in Ruby here, 100% of the app is written in Ansible.

The simple app presents an upload form where you upload an image. Uploaded images are displayed on the index.

`main.yml` is the router, it calls different routes based on METHOD and PATH.

There is no documentation, because, why not, LOL.

If you try this, you'll need to edit the `datadir` attribute in `deception.rb`
## To-Do:
* Get the description feature working
* Write a session manager
* Store data in Redis (shell out to redis-cli, why not?)
* Tabular results (should be no problem with Jinja)
* Spinning images?
