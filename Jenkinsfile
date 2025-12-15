pipeline {
    agent any

    environment { //add dockerhhub registry info
        DOCKER_REGISTRY = 'https://index.docker.io/v1/'
        DOCKER_IMAGE = 'chedlyrebai/student-management-app'
        DOCKER_TAG = 'latest'
    }

    stages {
     //   stage('Build') {
            // agent{
            //     docker {
            //         image 'maven:4.0.0-rc-5-amazoncorretto-25-debian-trixie'
                //         reuseNode true
                //     }
                // }

            //     steps {
            //         sh 'mvn -B -DskipTests clean package'
            //         sh 'echo "Build completed"'
            //     }
            // }

        // stage('Test') {
                // agent{
                    //     docker {
                //         image 'maven:4.0.0-rc-5-amazoncorretto-25-debian-trixie'
                //         reuseNode true
                //     }
                // }

            //     steps {
            //         sh 'mvn test'
            //         sh 'echo "Tests executed"'
            //     }
            // }
        stage('Test with sonarqube') {
            // environment {
            //     SONAR_TOKEN = credentials('jenkins-sonarqube')
            // }
            // steps {
            //     withSonarQubeEnv(installationName: 'sq1') {
            //         sh 'echo $SONAR_TOKEN'
            //         sh 'mvn sonar:sonar'
            //         sh 'mvn clean verify sonar:sonar -Dsonar.login=$SONAR_TOKEN'
            //     }
            // }

            environment {
                SONAR_TOKEN = credentials('sonar-token')
            }
            steps {
                sh """
                    mvn clean verify sonar:sonar \
                    -Dsonar.projectKey=student-management \
                    -Dsonar.host.url=http://localhost:9000 \
                    -Dsonar.login=$SONAR_TOKEN
                """
            }
        }

    //    stage('Deploy to Kubernetes') {
    //         steps {
    //             sh '''
    //                 kubectl set image deployment/student-deployment student-app=student-management:${BUILD_NUMBER} -n devops
    //                 kubectl rollout status deployment/student-deployment -n devops
    //             '''
    //         }
    //     }
        // stage('Build Docker image') {
        //     // steps{
        //     //     sh 'docker build -t chedlyrebai/student-management-app:latest .'
        //     // }
        //     steps{
        //         script {
        //             docker.build("${DOCKER_IMAGE}")
        //         }
        //     }
        // }

        // stage('Docker login') {
        //     steps {
        //         withDockerRegistry([
        //             credentialsId: 'chedlyrebai-dockerhub',
        //             url: 'https://index.docker.io/v1/'
        //         ]) {
        //             sh 'echo docker login successful'
        //             sh "docker push ${DOCKER_IMAGE}"
        //             sh 'echo "docker push successful"'
        //         }
            // script {
            //     docker.withRegistry("https://${DOCKER_REGISTRY}","chedlyrebai-dockerhub"){
            //         sh 'echo "Docker login successful"'
            //     }
            // }
        //     }
        // }
        // stage('Push docker image to github') {
        //     steps {
        //         script {
        //             docker.withRegistry("https://${DOCKER_REGISTRY}", 'chedlyrebai-dockerhub') {
        //                 def app = docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}")
        //                 app.push()
        //             }
        //         }
        //     }
        // }

        // stage('Archive artifact') {
        //     steps {
        //         archiveArtifacts artifacts: 'target/*.jar'
        //     }
        // }
        
    }
    post {
        failure {
            mail to:'chedly.rebai123@gmail.com',
            subject : "Build Failed in Jenkins: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
            body : "Please go to ${env.BUILD_URL} to view the results."
        }
        success {
            mail to:'chedly.rebai123@gmail.com',
            subject : "Build Success in Jenkins: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
            body : "Please go to ${env.BUILD_URL} to view the results."
        }
    }
}