# angular-universal-setup

This is a small Angular Universal starter project. The project has the following features.
1. An Angular 5 development environment setup using Vagrant
2. Building Docker image and running the angular app in a Docker container

## The Tools
1. Vagrant (with plugin vagrant-fsnotify)
2. VirtualBox
3. Git
4. Visual Studio Code

## The Steps to Launch the Development Environment
1. Set an environment variable - MYENV=DEV
2. Clone the Git repository: https://github.com/saptarshibasu/angular-universal-setup
3. Go to the directory: angular-universal-setup
4. Run `vagrant up`
5. Run `vagrant fsnotify`

Note: Wait for 2-3 minutes after `vagrant up` exits for the URL http://localhost:4200 become available

## The Steps to run the application in a Docker container
1. Remove the environment variable - MYENV=DEV
2. Clone the Git repository: https://github.com/saptarshibasu/angular-universal-setup
3. Go to the directory: angular-universal-setup
4. Run `vagrant up`

Note: The app will be accessible at http://localhost:4000

## Shutdown
1. `vagrant halt` will shutdown the virtual machine
2. `vagrant destroy` will destroy the virtual machine

##Project Setup Notes
The Angular Universal setup steps are detailed here: https://angular.io/guide/universal

However, I need to do a few things to get things working due to version incompatibility among various packages.
1. Webpack 3 is not compatible with ts-loader versions higher than 3.5.0. At the time of developing this, the latest version of Angular CLI is 1.7.2 which uses Webpack 3.*. Hence, while setting up Angular Universal, install ts-config@3.5.0
2. `webpack.ContextReplacementPlugin` plugin syntax used in the documentation doesn't seem to work with Webpack 3.* and hence I had to use the alternative syntax
