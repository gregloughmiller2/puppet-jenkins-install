#
export PATH=$PATH:/opt/puppetlabs/bin
#
puppet apply puppet/manifests/site.pp --modulepath=/vagrant/puppet/modules/
