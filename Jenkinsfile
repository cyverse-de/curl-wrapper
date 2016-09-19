#!groovy
def repo = "curl-wrapper"
def dockerUser = "discoenv"

node {
    slackJobDescription = "job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
    try {
        stage "Build"
        checkout scm

        sh 'git rev-parse HEAD > GIT_COMMIT'
        git_commit = readFile('GIT_COMMIT').trim()
        echo git_commit

        dockerRepo = "${dockerUser}/${repo}:${env.BRANCH_NAME}"

        sh "docker build --rm --build-arg git_commit=${git_commit} -t ${dockerRepo} ."


        stage "Docker Push"
        sh "docker push ${dockerRepo}"
    } catch (InterruptedException e) {
        currentBuild.result = "ABORTED"
        slackSend color: 'warning', message: "ABORTED: ${slackJobDescription}"
        throw e
    } catch (hudson.AbortException e) {
        currentBuild.result = "ABORTED"
        slackSend color: 'warning', message: "ABORTED: ${slackJobDescription}"
        throw e
    } catch (e) {
        currentBuild.result = "FAILED"
        sh "echo ${e}"
        slackSend color: 'danger', message: "FAILED: ${slackJobDescription}"
        throw e
    }
}
