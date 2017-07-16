# Pentaho Development Environment

This project provides tools useful for developing pentaho platform components, plugins, and extensions.

It provides the following to make it fast and easy to get started and get things done.

| Folder | Description |
| --- | --- |
| [Scripts](scripts) | A set of common convenience scripts that automate a lot of development tasks, such as building, running, testing, and validating pentaho platform components.  |
| [Vagrant](vagrant) | Provides a neat little development environment in a can.  A Vagrant VM with all dev tools pre-installed and configured (maven, java, docket, etc).  Just pull from git, set a few env variables, run "vagrant up" and start developing.  |
| [Docker](docker) | A docker container with all tools necessary to run & test pentaho platform built in.  So you don't have to set up a local environment to run the platform. |

It is:
* **Portable** - 
  - Moving to a new developemnt laptop?  Recreate your entire dev environment in a few easy steps and pick up where you left off.
  - Same environment across Linux, Mac OSx, Windows and others...any OS that Vagrant and Docker supports
  - Consistent development workflow across multiple machines (e.g. work desktop running Mac OSx & home laptop running Windows)
* **Disposable** 
  - Screw something up?  Destroy your old dev environment and start over.
* **Sharable** -
  - Quick local dev environment setup for new team members
  - Common development environment for all team members
  
