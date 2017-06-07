export PATH=$PATH:/opt/puppetlabs/bin
#
puppet-lint puppet/manifests/site.pp
puppet-lint puppet/modules/getjenkins
#
puppet apply puppet/manifests/site.pp --modulepath=/vagrant/puppet/modules/ --noop
