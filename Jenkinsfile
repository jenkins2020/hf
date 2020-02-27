#!/bin/groovy
pipeline {
    agent {
        dockerfile true
    }

    stages {
        stage('Init') {
            steps {
                sh('rpmdev-setuptree')
                sh('cd ~/rpmbuild/SOURCES; wget -c http://ftp.gnu.org/gnu/hello/hello-2.10.tar.gz')
                sh('cd ~/rpmbuild/SPECS; rpmdev-newspec hello')
            }
        }
        stage('Build') {
            steps {
                sh('cp hello.spec ~/rpmbuild/SPECS')
                sh('cd ~/rpmbuild/SPECS; rpmbuild -ba hello.spec')
            }
        }
        stage('Deploy') {
            steps {
                archiveArtifacts(artifacts: '/home/user/rpmbuild/RPMS/*.rpm')
            }
        }
    }
}
