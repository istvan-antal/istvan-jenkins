class jenkins {

    service { "jenkins":
        require => File['/etc/default/jenkins'],
        ensure => running,
        enable => true,
        hasrestart => true,
    }

    file { '/etc/default/jenkins':
        require => Package["jenkins"],
        source  => "${settings::modulepath}/jenkins/etc/default/jenkins",
        notify  => Service["jenkins"]
    }

    package { "jenkins":
        ensure => "installed",
        require => File['/etc/apt/preferences.d/jenkins'],
    }

    file { '/etc/apt/preferences.d/jenkins':
        source  => "${settings::modulepath}/jenkins/etc/apt/preferences.d/jenkins",
        require => Exec['create_jenkins_sources_list'],
    }

    exec { "create_jenkins_sources_list":
        command => "${settings::modulepath}/jenkins/install_jenkins_sources_list.sh",
        creates => "/etc/apt/sources.list.d/jenkins.list",
        logoutput => true,
        timeout => 1800
    }

}
