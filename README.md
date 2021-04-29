# Lessonly Local Dev Config

This project is intended for the purposes of making it easy to share and maintain development environtment configuration for lessonly developers.

When you receive your Lessonly MacBook, start here before setting up other tools.


@TODO make this work for non-mac developers as well

# Getting Started

## MacOS

1. Open a Terminal window and run `git`. This will prompt you to install Xcode tools. Install it.
2. Open a browser window to https://github.com and log in to Github.
3. Download and install [Docker for Mac](https://docs.docker.com/docker-for-mac/install/).
    - Once you have it installed, run and log in to the Docker app. You may need to sign up if you haven't done this before.
4. In your Terminal window, change to the directory where you want git repositories to go, and clone this repo.
    ```sh
    git clone https://github.com/lessonly/lldevconfig.git
    cd lldevconfig
    ```
5. Run the bootstrap script
    ```sh
    bin/bootstrap
    ```
    - This will require user input a few times, including:
    - Enter your computer password to install Homebrew
    - Enter your computer password to change your default shell
    - Enter the email address you use in Github to create your SSH key
    - Enter a password to protect your SSH key
    - Add your SSH key in Github. It should copy the key and open a page to [the Github SSH keys page](https://github.com/settings/keys) for you to make it easy.
6. Open a new Terminal window and close the old one so that it loads zsh. This step is optional.
7. `cd` to the `lldevconfig` project directory.
8. Run the configuration script with `sudo`.
    ```sh
    sudo bin/lldevconfig
    ```
    - If this fails with the following error messages:
        ```
        Comment: State 'x509.private_key_managed' was not found in SLS 'pki'
        Reason: 'x509' __virtual__ returned False: Could not load x509 state: m2crypto 
        ```
        You will need to run the following command
        ```
        /usr/local/Cellar/salt/3003/libexec/bin/pip3.9 install m2crypto
        ```
        > Note: your salt version may be different so tab complete to replace 3003 with the version you have installed
    - This sometimes fails to restart nginx and dnsmasq. If this happens, run the above command a second time. It usually works then.
    - You may need to click "Allow" in a popup window for nginx.
    - If you want to see what all is going to be performed before running it you can do the following:
        ```sh
        sudo bin/lldevconfig state.highstate test=True
        ```

At this point, you have everything you need to clone a project and follow its setup instructions. We recommend visiting https://github.com/lessonly/lessonly and following the setup instructions there, first. That's our core app and most likely where you'll be spending more of your time.

## Other operating systems

We don't officially support other operating systems right now.

# How It works

This is script uses salt to manage the state of your machine.  The goal is to stay out of your way and be a good citizen.  The goal is for all files to live in the `~/.lldev` directory when possible.  There are other files (service, configurations that may have to be put elsewhere).

## Configuration

Some configuration can be managed via grains:

Look here to see what all gets set up:

https://github.com/lessonly/lldevconfig/blob/master/base_config/grains

# What is currently included

## Nginx Dev Frontend

- This script will start up an nginx instance that will serve as a reverse proxy to a rails backend on port 3000
- This script also will generates a root CA, and trusts it for you.  It then signs a certificate for you that nginx will then use.

## zsh

This script sets up [zsh](http://zsh.sourceforge.net/) as your default shell. We recommend also installing [oh-my-zsh](https://ohmyz.sh/), which makes your shell much more useful.

## asdf

[asdf](https://asdf-vm.com) is a dependency version manager. It uses our `.tool-versions` files to determine what version of Ruby, NodeJS, Yarn, and other tools each project needs. It ensures the right versions are installed and used in the context of those projects.

## Homebrew

[Homebrew](https://brew.sh/) is a dependency manager which acts on a system level (whereas asdf works primarily on a project level).

