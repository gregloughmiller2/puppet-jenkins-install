# Install Jenkins
node default {
    case $::operatingsystem {
        'Ubuntu' : { notify {"$::operatingsystem is supported":} }
        default  : { notify {"$::operatingsystem is not supported yet":} }
    }
    include getjenkins
}
