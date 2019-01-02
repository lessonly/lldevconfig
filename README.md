# Lessonly Local Dev Config

This project is intended for the purposes of making it easy to share and maintain development environtment configuration for lessonly developers.


@TODO make this work for non-mac developers as well

# Getting Started

## MacOS

It is assumed you have homebrew installed.  

Install salt (it does the heavy lifting)

```brew install salt```

## Ubuntu


[Install Salt Deb Repo](https://repo.saltstack.com/#ubuntu)

After that is installed, ensure the mcrypt package is installed: 

```apt-get install python-m2crypto```

# run the scripts

## Bootstrap the script

This creates the .lldev directory, and sticks 2 configuration files in it.  `minions` you should never have to touch.   `grains` contains configuration options that we might want to change at some point based on preferences.

```bin/bootstrap```


## Run lldevconfig

Run this command in sudo.  It will drop down to your user when it can.  I originally wanted to seperate the root level access from the user-level, but it is going to end up being different on different operating systems.

```sudo bin/lldevconfig```

And you should be done.

If you want to see what all is going to be performed before running it you can do the following:

``` sudo bin/lldevconfig state.highstate test=True```


# How It works

This is script uses salt to manage the state of your machine.  The goal is to stay out of your way and be a good citizen.  The goal is for all files to live in the ~/.lldev directory when possible.  There are other files (service, configurations that may have to be put elsewhere).

## Configuration

Some configuration can be managed via grains:

Look here to see what all gets set up:

https://github.com/lessonly/lldevconfig/blob/master/base_config/grains

# What is currently included

## Nginx Dev Frontend

- This script will start up an nginx instance that will serve as a reverse proxy to a rails backend on port 3000
- This script also will generates a root CA, and trusts it for you.  It then signs a certificate for you that nginx will then use.

