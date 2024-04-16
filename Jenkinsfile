pipeline{
    
    tools{
        // what tool version to use for build stages
        maven 'mymaven'
    }
    
    agent { label 'jenkins-slave' }

    stages{
        
        stage ('CloneRepo')
        {
            steps{
              git 'https://github.com/RaphDevOps/industry-grade-project.git'  
            }
        }
        
        stage ('Compile')
        {
            steps{
                
             sh  'mvn compile'
                
            }
        }
        stage ('CodeReview')
        {
            steps{
                
             sh  'mvn pmd:pmd'
                
            }
            post{
                success{
                    recordIssues(tools: [pmdParser(pattern: '**/pmd.xml')])
                }
            }
        }
        stage ('TestCode')
        {
            steps{
                
             sh  'mvn test'
                
            }
        post{
            success{
                junit 'target/surefire-reports/*.xml'
            }
        }
        }
        
        stage('packageCode')
        {
            steps{
                sh 'mvn package'
            }
        }
        stage('Build the image') {
            steps {
                sh 'cp /var/lib/jenkins/workspace/CICDPipeline/target/ABCtechnologies-1.0.war .'
                sh 'docker build -t ABCtechnologies:$BUILD_NUMBER .'
            }
        }
        stage('Run the application') {
            steps {
                sh 'docker run -d -P ABCtechnologies:$BUILD_NUMBER'
                sh 'docker ps -a'
            }
        }

  }
    
}
