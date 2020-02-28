#!/bin/groovy
pipeline {
    parameters {
        string(name:'VERSION', defaultValue:'latest', description:'Fedora version')
    }

    agent {
        dockerfile {
            additionalBuildArgs  "--build-arg version=${VERSION}"
        }
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
                // Copy artifacts back into workspace, versioned.
                sh("mkdir -p build_${VERSION}/")
                sh("cp ~/rpmbuild/RPMS/*/*.rpm build_${VERSION}/")
            }
        }
        stage('Deploy') {
            steps {
                // zip() needs non-default plugin 'file-operations'
                //zip(zipFile: "hello.fedora:${VERSION}.zip", archive: true, glob: '*.rpm')
                // archiveArtifacts() doesn't trivially allow versioning.
                archiveArtifacts(artifacts: "build_${VERSION}/*.rpm")
            }
        }
    }
    
    post {
        always {
            echo 'YAY!'
        }
        /*
        success { 
            echo 'Call test pipeline here'
            build(job: 'hf_testrpm', wait: true)
            // TODO^2 use matrix to call other pipeline
        }
        */
        cleanup {
            cleanWs()  // uses worspace-clean plugin
        }
    }
}
