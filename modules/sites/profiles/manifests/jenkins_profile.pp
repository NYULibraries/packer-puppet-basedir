# == Class: profile
#
# Full description of class profile here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'profile':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class profiles::jenkins_profile {

  #include jenkins

  class { 'jenkins' :
    configure_firewall => true,
  }

  firewall { '100 allow jenkins access on 8180' :
    dport  => [8180],
    proto  => tcp,
    action => accept,
  }
  #
  # Plugins
  #
  #jenkins::plugin {
  #  'ansicolor' :
  #    version => '0.3.1';
  #}
  jenkins::plugin { 'ansicolor' : }
  jenkins::plugin { 'chucknorris' : }
  jenkins::plugin { 'chroot' : }
  jenkins::plugin { 'database-mysql' : }
  jenkins::plugin { 'docker-plugin' : }
  jenkins::plugin { 'docker-commons' : }
  jenkins::plugin { 'git' : }
  jenkins::plugin { 'github' : }
  jenkins::plugin { 'ghprb' : }  # github pull request builder
  jenkins::plugin { 'gitlab-plugin' : }
  jenkins::plugin { 'gitlab-hook' : }
  jenkins::plugin { 'gitlab-merge-request-jenkins' : }
  jenkins::plugin { 'packer' : }
  jenkins::plugin { 'pyenv' : }
  jenkins::plugin { 'python' : }
  jenkins::plugin { 'python-wrapper' : }
  jenkins::plugin { 'puppet' : }
  jenkins::plugin { 'rbenv' : }
  jenkins::plugin { 'rake' : }
  jenkins::plugin { 'ruby-runtime' : }
  jenkins::plugin { 'rvm' : }
  jenkins::plugin { 'selenium-builder' : }
  jenkins::plugin { 'ssh' : }
  jenkins::plugin { 'terminal' : }
  jenkins::plugin { 'vagrant' : }
  # AWS plugins
  #jenkins::plugin { 'aws-codepipeline' : }
  #jenkins::plugin { 'aws-credentials' : }
  #jenkins::plugin { 'jenkins-cloudformation-plugin ' : }
  #jenkins::plugin { 'ec2' : }
  #jenkins::plugin { 'github-sqs-plugin' : }

  # jenkins plugins
  #jenkins::plugin { 'dry-run' : }
  #jenkins::plugin { 'housekeeper' : }
  #jenkins::plugin { 'jenkinslint' : }
  #jenkins::plugin { 'throttle-concurrents' : }
  #jenkins::plugin { 'uptime' : }

  #jenkins::user { 'dbcooper' :
  #  email    => 'flannon@nyu.edu',
  #  password => 'changeme',
  #}

  #  jenkins::job {
  #  'build' :
  #    config => '<?xml version=\'1.0\' encoding=\'UTF-8\'?>
#<project>
 #<actions/>
  #<description></description>
  #<keepDependencies>false</keepDependencies>
  #<properties></properties>
  #<scm class="hudson.scm.NullSCM"/>
  #<canRoam>true</canRoam>
  #<disabled>false</disabled>
  #<blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  #<blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  #<triggers/>
  #<concurrentBuild>false</concurrentBuild>
  #<builders/>
  #<publishers/>
  #<buildWrappers/>
#</project>';
#    }
}
