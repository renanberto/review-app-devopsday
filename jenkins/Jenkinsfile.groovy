node() {

  def PULL_ID = params.PULL_ID

  stage('Verification'){

    if (${PULL_ID}?.empty){
      error("PULL_ID is empty.")
    }

    sh"rm -rf *"
  }

  stage('Checkout Git'){

    checkout(
      [$class: 'GitSCM', branches: [[name: 'refs/remotes/origin/pr/${PULL_ID}/head']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', refspec: '+refs/pull/*:refs/remotes/origin/pr/*', url: 'git@github.com:renanberto/test-review-app.git']]]
    )
  }

  stage('Build'){

    sh"""
      docker run --rm \
      -v /storage/jenkinsData/workspace/devops-day-review-app:/go/src/review-app \
      golang:1.9 bash -c "cd /go/src/review-app/app/ && \
        export GOPATH="/go" && \
        go get gopkg.in/macaron.v1 && \
        go build -v main.go"
    """
  }

  stage('Create image'){

    sh"""
      docker build -t devops-day-image .
    """
  }

  stage('Create container'){
    sh"""
      docker run -p 4000:4000 -tid --name hello_world_devopsday devops-day-image
    """
  }

}
