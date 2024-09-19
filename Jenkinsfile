pipeline {
    agent any

    stages {
        stage('checkout a branch') {
            steps {
                git 'https://github.com/mahesh241994/maven-web-app.git'
            }
        }
        stage ('build') {
            steps {
                sh ''' mvn clean package '''
            }
        }
        stage ("code quality on sonarqube") {
            steps {
                    sh ''' mvn clean verify sonar:sonar -Dsonar.projectKey=maven-application-deploy -Dsonar.projectName='maven-application-deploy' -Dsonar.host.url=http://54.215.93.62:9000 -Dsonar.token=sqp_87ee7d7702a870a991167dec2cf0c6368daec210 '''
            }
        }
        stage ("artifactory upload") {
            steps {
                    sh ''' curl -v -u admin:admin123 --upload-file /var/lib/jenkins/workspace/mavenapp/target/maven-web-app.war http://13.57.245.13:8081/nexus/content/repositories/mavenapp/ '''
            }
        }
        stage ("create a custom image") {
            steps {
                sh ''' docker build -t mavenapp . '''
                sh ''' docker tag mavenapp mahesh9948/mavenwebapp:v1.1.1 '''
            }
        }
        stage ('Push into Dokcerhub') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'Docker-hub') {
                        sh ''' docker push mahesh9948/mavenwebapp:v1.1.1 '''
                    }
                }
            }
        }
        stage ("Run the Application "){
            steps {
                sh ''' docker run --name mavenapp -d -p 8088:8080 mahesh9948/mavenwebapp:v1.1.1 '''
            }
        }
    }
}
