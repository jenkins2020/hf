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
                sh('cp /home/user/rpmbuild/RPMS/*/*.rpm .')
            }
        }
        stage('Deploy') {
            steps {
                archiveArtifacts(artifacts: '*.rpm')
            }
        }
    }
}
