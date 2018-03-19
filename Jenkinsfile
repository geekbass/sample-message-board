#!groovy

node {

  def err = null
  def environment = "Development"
  currentBuild.result = "SUCCESS"

  try {
    stage ('Checkout') {
      checkout scm
    }
    
    stage ('Build the new Docker Image') {
      sh """
       set +x
       cd sample-message-board/ && docker build -t bold-rails:${env.BUILD_TAG} .
       """
    }

    stage ('Stop Current Rails App') {
      sh """
       set +x
       docker stop rails 
       """
    }


    stage ('Remove Current Rails App') {
      sh """
       set +x
       docker rm rails 
       """
    }
    
    stage ('Start New Rails App from New Image') {
      sh """
       set +x
       docker run -d --rm  --link postgres --name rails -p 5000:5000  bold-ruby:${env.BUILD_TAG} bundle exec rails s -p 5000 -b '0.0.0.0' 
       """
    }
#
 #   stage ('Notify') {
  #    mail from: "email@email.com",
   #        to: "email@email.com",
    #       subject: "Rails Release for ${environment} Complete.",
     #      body: "Jenkins Job ${env.JOB_NAME} - build  ${env.BUILD_NUMBER} for ${environment}. Please investigate."
    #}
  }

  catch (caughtError) {
    err = caughtError
    currentBuild.result = "FAILURE"
  }

  finally {
    /* Must re-throw exception to propagate error */
    if (err) {
      throw err
    }
  }
}