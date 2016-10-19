class jenkins {
    exec { "create_jenkins_sources_list":
        command => "${settings::modulepath}/jenkins/install_jenkins_sources_list.sh",
        creates => "/etc/apt/sources.list.d/jenkins.list",
        logoutput => true,
        timeout => 1800
    }

    package { "jenkins":
        ensure => "installed",
        require => Exec['create_jenkins_sources_list'],
    }
}