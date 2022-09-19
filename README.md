# Lessonly Local Dev Config

This project is intended for the purposes of making it easy to share and maintain development environtment configuration for lessonly developers.

When you receive your Lessonly MacBook, start here before setting up other tools.

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
   - Enter your computer password to install local root cert for Caddy
   - Enter your computer password to change your default shell
   - Enter the email address you use in Github to create your SSH key
   - Enter a password to protect your SSH key (you will be asked 3 times)
   - Add your SSH key in Github. It should copy the key and open a page to [the Github SSH keys page](https://github.com/settings/keys) for you to make it easy.
6. Once this script completes, you should close this window and open a new terminal so that it loads zsh.
7. If you running an Mac with an apple silicon CPU (M1/M2) please run the M1 laptop steps below before setting up projects just yet

At this point, you have everything you need to clone a project and follow its setup instructions. We recommend visiting https://github.com/lessonly/lessonly#getting-started and following the setup instructions there, first. That's our core app and most likely where you'll be spending more of your time.

### Apple Silicon MacOS (M1/M2 Cpus)

This is a temporary workaround for some preinstalled seismic software colliding with our local development environment. We are working with security team and helpdesk to alleviate this issue.

1. Verify our custom domain setup. Run this command.
   - `curl https://caddystatus.lessonly.test`
2. If this returns "Caddy works: GET https://caddystatus.lessonly.test/", great you're done! Go setup some projects.
3. If it doesn't, we need to uninstall some preinstalled software to enable our development environment.
4. Uninstall Umbrella Roaming Client `sudo /Applications/OpenDNS\ Roaming\ Client/rcuninstall`
5. Restart computer **Do not skip this step**
6. Reinstall dnsmasq
   - `brew reinstall dnsmasq`
   - Brew may ask you to remove some files do so with `sudo rm -rf /opt/homebrew/Cellar/dnsmasq/2.86.reinstall`
   - After removing the needed file, run reinstall again `brew reinstall dnsmasq`
7. Verify dnsmasq is now in the "started" status `sudo brew services list`
8. Verify `curl https://caddystatus.lessonly.test` "Caddy works: GET https://caddystatus.lessonly.test/"

## Other operating systems

We don't officially support other operating systems right now.

# How It works

This is script sets up 3 things:

- port forwarding of 80 & 443 over to non-standard ports
- dnsmasq to handle `*.lessonly.test` domains
- caddy to handle certificates and reverse proxy to local lessonly

# What is currently included

## Caddy Dev Frontend

- This script will start up a caddy instance that will serve as a reverse proxy to a rails backend on port 3000

## zsh

This script sets up [zsh](http://zsh.sourceforge.net/) as your default shell. We recommend also installing [oh-my-zsh](https://ohmyz.sh/), which makes your shell much more useful.

## asdf

[asdf](https://asdf-vm.com) is a dependency version manager. It uses our `.tool-versions` files to determine what version of Ruby, NodeJS, Yarn, and other tools each project needs. It ensures the right versions are installed and used in the context of those projects.

## Homebrew

[Homebrew](https://brew.sh/) is a dependency manager which acts on a system level (whereas asdf works primarily on a project level).
