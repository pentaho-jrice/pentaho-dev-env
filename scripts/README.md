# Dev Environment Convience Scripts 

**NOTE!!!**

Don't really have time to set up a nicely formatted README that's radable.  So, just going to jot down notes to use for later.
Will come back and update this page to make it shareable

# Common environment variables that shold be set by the user. 

The scripts will try to make reasonable defaults based relative to the vagrantfile directory.


## Both Local Dev & Remote VM

| variable name | description | higly encoured | default value |
| ------ | ----------- | ------ | ----------- | ----------- |
| $LOCAL_GIT_PROJECTS_HOME | location where git files are stored on local machine. | x | ~/git |
| $LOCAL_MAVEN_CONF_DIR | Location of the local maven configuration file. | | ~/git |
| $LOCAL_MAVEN_REPO_DIR | Location of the local maven configuration file. | | ~/git |
| $AWS_ACCESS_ID | Your private aws access id | | <no-default - you will have to set it manually in the VM |
| $AWS_SECRET_KEY | Your private aws access id | | <no-default - you will have to set it manually in the VM |

# Remote VM
| variable name | description | higly encoured | default value |
| ------ | ----------- | ------ | ----------- | ----------- |
| $GIT_PROJECTS_HOME | location where git files will be stored on the VM. | | ~/git |

