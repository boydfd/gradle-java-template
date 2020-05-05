pipeline {
    agent none
    options { skipDefaultCheckout(); timeout(time: 1, unit: 'HOURS'); }
    stages {
		stage('Test/Build') {
			agent { kubernetes { label 'gradle' }}
			steps {
				checkout scm
				container ('gradle') {
					sh './gradlew clean checkstyleMain'
					sh './gradlew checkstyleTest'
					sh './gradlew pmdMain'
					sh './gradlew pmdTest'
					sh './gradlew test'
					sh './gradlew build'
				}
			}
			post {
				always {
					junit 'build/test-results/**/*.xml'
					step( [ $class: 'JacocoPublisher' ] )
					sh '''
						cp build/libs/*.jar docker/app.jar
						rm -rf docker/deps
						mkdir -p docker/deps
						$(cd docker/deps; jar -xf ../app.jar)
					'''
				}
				success {
					archiveArtifacts artifacts: 'docker/*', fingerprint: true
					archiveArtifacts artifacts: 'docker/deps/**/*', fingerprint: true
				}
			}
		}

        stage('Build Docker') {
			agent { kubernetes { label 'docker' }}
            steps {
				container ('docker') {
					step([$class              : 'CopyArtifact',
						  filter              : 'docker/deps/**/*',
						  fingerprintArtifacts: true,
						  projectName         : '${JOB_NAME}',
						  selector            : [$class: 'SpecificBuildSelector', buildNumber: '${BUILD_NUMBER}']
					])
					step([$class              : 'CopyArtifact',
						  filter              : 'docker/*',
						  fingerprintArtifacts: true,
						  projectName         : '${JOB_NAME}',
						  selector            : [$class: 'SpecificBuildSelector', buildNumber: '${BUILD_NUMBER}']
					])
					sh 'docker/build.sh'
				}
            }
        }
    }
}