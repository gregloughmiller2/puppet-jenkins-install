REPO=https://github.com/gregloughmiller1/puppet-jenkins-install.git
DIR=puppet-jenkins-install
echo "Remove the git clone directory if present for subsequent executions" 
if [  -d "$DIR" ]; then
	cd $DIR
        vagrant destroy -f
	cd ..
	rm -rf $DIR
	if [ $? -gt 0 ]; then
		echo ">>> Unable to delete $DIR" 
		exit 1
	fi
fi
echo "Clone the Challenge repo from gregloughmiller1 github"
git clone "$REPO"
if [ $? -eq  0 ]; then
        echo "Move into the working directory of repo to start process of building virtualbox VM via vagrant"
	cd "$DIR"
        ./build_vm.sh
	if [ $? -gt 0 ] ; then
		echo "Building of VM and puppet installation failed"
		exit 111
	fi
else
	echo "error with git"
	exit 1
fi
