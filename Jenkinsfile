#!/bin/groovy
pipeline {
    agent {
        dockerfile true
    }

    options { timestamps() }

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
                sh('cp ~/rpmbuild/RPMS/*/*.rpm .')
            }
        }
        stage('Deploy') {
            steps {
                archiveArtifacts(artifacts: '*.rpm')
            }
        }
    }
    
    post {
        always {
            echo 'YAY!'
        }
        success { 
            echo 'Call test pipeline here'
            build(job: 'hf_testrpm', wait: true)
            // TODO^2 use matrix to call other pipeline
        }
        cleanup {
            cleanWs()  // uses worspace-clean plugin
        }
    }
}
