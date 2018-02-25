# angular-universal-setup

This is a small demo project. The project has the following features.
1. An Angular 5 development environment setup using Vagrant
2. Building Docker image with Angular Universal and Angular GUI distribution (in progress)

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

## Shutdown
1. `vagrant halt` will shutdown the virtual machine
2. `vagrant destroy` will destroy the virtual machine
