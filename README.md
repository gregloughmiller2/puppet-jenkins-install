# puppet-jenkins-install

## Objective

Automated installation and configuration of Jenkins using Puppet on a fresh vagrant box with Ubuntu 16.04 LTS

## Requirements:
* (a) The solution must run on a clean installation of the chosen operating system without errors.
* (b) Jenkins and its prerequisites must be installed without a manual intervention.
* (c) Jenkins must be configured to serve requests over port 8000. (NOTE: No port forwarding!!)
* (d) Subsequent applications of the solution should not cause failures or repeat redundant configuration tasks.

## Prerequisites and Assumptions

### Configuration and software prerequisites

* Use of preconfigured box via Hashicorp: https://atlas.hashicorp.com/puppetlabs/boxes/ubuntu-16.04-64-puppet
* Use of clean Ubuntu 16.04 image for virtual box VM created via Vagrant
* The host is required to have git installed. 
* Vagrant version 1.9.5
* Puppet version on pre-configured box tested is 4.5.1
* VirtualBox version 5.1.22 r115126 (Qt5.6.2)
* All code and manifests related to this are stored within GitHub Repo as defined in later section
* Jenkins will be available on port 8000
* VM will have a virtualbox host-only interface with IP address of 50.50.50.111 to test host access to Jenkins within VM
* VM will have a virtualbox nat'd interface with IP address of 10.0.2.15
* Vagrantfile will be used to provision the VM within Virtualbox
* Vagrantfile will contain the puppet provisioner to enable execution of the manifests to install Jenkins
* The working directory will be shared between the VM and the host
* This project was tested upon MAC OS X 10.11.6. This would work with Linux yet not a Windows host. 
* The testing script was written in bash for Linux.
* Subsequent executions from within the VM of the puppet manifests should be done via root (or via sudo functionality that is already provisioned on VM)
* Subsequent executions of the automation script (run_challenge.sh) will  remove a VM built via Vagrant and remove the directory created via cloning from GitHub.
* Testing will be initiated with the execution of the run_challenge.sh script

### github repository

https://github.com/gregloughmiller1/puppet-jenkins-install 

This repo will contain all files for this project; including the script provided via submission for starting the deployment,
run_challenge.sh.

### vagrant configuration

The Vagrantfile uses a Ubuntu 16.04 LTS box from Hashicorp with Puppet pre-installed.  
https://atlas.hashicorp.com/puppetlabs/boxes/ubuntu-16.04-64-puppet

The Vagrantfile will configure the VM as follows:
* (1) defines box to add
* (2) Configures a private network with ip of 50.50.50.111 (allows use of host browser to validate Jenkins connectivity)
* (3) Allocates just 1024MB of memory to the VM (host limitation on test environment)
* (4) Configures the shell provisioner to install the Puppet stdlib module
* (5) Configures the Puppet provisioner by defining the environment, the manifest path, module path and manifest file to use

### Testing Directions

Execute the provided shell script, run_challenge.sh, from a new directory on the host machine. This script will build the VM based on
Vagrantfile definitions, and apply the puppet manifest site.pp as a result of the Vagrantfile file using the Puppet Provisioner.  

If executed on a Windows host; the following commands would be required to be executed via Windows prompt:
* git clone https://github.com/gregloughmiller1/puppet-jenkins-install.git
* cd puppet-jenkins-install
* vagrant box add puppetlabs/ubuntu-16.04-64-puppet --provider virtualbox -f
* vagrant up

The Puppet manifest, site.pp, will perform the following steps
* (a) Install Jenkins key via apt-key add, if necessary, when Jenkins keys are not present
* (b) Create the apt sources file for Jenkins, if not present
* (c) Perform an apt-get update
* (d) Install the latest jenkins package, if necessary.
* (e) Modify the Jenkins port to 8000 from 8080, as required
* (f) Ensure that Jenkins service is running on the VM

### puppet manifests and modules

The site.pp will validate that this is an Ubuntu OS, and use the class "getjenkins" to accomplish the installation and configuration 
of Jenkins on the VM. 

## Questions

### Describe the most difficult hurdle you had to overcome in implementing your solution 

I initially wanted to use Ansible to complete this task as that is what I'm most familiar with. But felt it necessary to start the
process using Puppet (why not - it's a puppet challenge). 
I had used puppet some in previous roles but looked at this as an opportunity to see how to install/configure Jenkins with Puppet. I
have used Vagrant quite a bit and was familiar with the Vagrant Provisioners. Yet had not used one for Puppet. Thus, that took time 
and research to ensure that I had proper parameters for the Puppet Provisioner based upon the documentation. 

I approached this effort by breaking it down into functional areas as I wasn't familiar with the Puppet Provisioner. I wanted to
decompose the functions to smaller working projects and then bring them together. This allowed me to break down the components for 
each to be successful and then combine all functions (Vagrant VM, Jenkins, and use of provisioners).

I reviewed several web sites, Git repos, blogs and documentation as I ran into some syntax issues. The one thing I had not known about
puppet was the ability to use the parser and puppet-lint This was very helpful for some simple missing syntax. 

The research from example Puppet manifests within Github, documentation and blogs created by others was of great value in creating this 
project. Coming from the Cloud space, I'm a fan of reusability of code as examples. I still have the habit of doing it my 
way, yet having those examples for methods and syntax via the community provided assistance in completing the project.

### Please explain why requirement (d) above is important. 

Configuration management depends upon the ability to re-execute functions/deployments/configuration on a consistent basis without
errors that can provide an environment that will function correctly upon the initial deployment. A working and known end-state
infrastructure that can be trusted by the end consumer of the infrastructure will instill credibility and confidence for the 
organization. One key point for automation is to be able to maintain a repeatable process that provides persistent configurations 
that are validated and not prone to manual configuration steps. Having supported multi-thousand databases - the ability to maintain a
persistent foundation allows support to be less complex and provides the agility and confidence for "go to market" deployments. 
Keeping the environments consistent after the initial deployment is as critical as the deployment. Ensuring that the configuration is 
maintained to mitigate errors from one-off manual changes made over periods of time to environments.  

### Where did you go to find information to help you 

Details found by researching how to install Jenkins via multiple blogs and websites. In addition; I used sites that had examples of
Puppet manifests to install packages, services, validating the presence of files, and documentation on the Vagrant Puppet provisioner. 
Below are some of the key resources used to identify steps to ensure accuracy in completing this challenge:

http://softwaretester.info/install-jenkins-with-puppet/

http://www.pindi.us/blog/getting-started-puppet

https://www.puppetcookbook.com

https://docs.puppet.com/ 

https://wiki.jenkins-ci.org/display/JENKINS/Install+Jenkins+with+Puppet 

https://www.vagrantup.com/docs/provisioning/puppet_apply.html

http://puppet-jenkins.readthedocs.io/en/latest/install.html

### Briefly explain what automation means to you, and why it is important to an organization's infrastructure design strategy 

Most work performed by Deployment engineers or Infrastructure engineers involve workflows that are typically manual, and repetitive. 
The use of configuration management tools can enable an IT organization to be more efficient and agile in serving the needs of the 
Customers. The tools for configuration management automate the manual and repetitive steps to provision infrastructure and/or software to ensure correctness and realign infrastructure from configuration drift. 

Having managed a team that supported thousands of databases; being able to perform a persistent end state without errors 
reduces time to deployment, minimizes the opportunity for errors and catastrophic failures. And, will provide a foundation where all deployments will be persistent that enables support to triage problems quicker. 

Another concept of configuration management and automation is just not about getting the deployment complete, but to maintain a persistent environment after the deployment. Over periods of time there are users that will alter various parts of the infrastructure that deviates it’s initial deployment away from an initial known state. Configuration management tools can mitigate that divergence form the proper state.

Documentation is typically one of the last things that will be created by System Admins or Deployment Engineers. Being able to use tools
like Puppet will provide the foundation of documentation for an infrastructure deployment. Configuration management tools can provide the source of truth for the platform and application deployment models. 

