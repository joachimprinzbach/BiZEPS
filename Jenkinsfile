def projectSettings = readJSON text: '''{
  "repository": {
    "url": "https://github.com/Zuehlke/BiZEPS.git",
    "credentials": "3bc30eda-c17e-4444-a55b-d81ee0d68981"
  },
  "dockerHub": {
    "user": "bizeps"
  },
  "dockerJobs": [
    {"imageName": "jenkins",      "dockerfilePath": "./buildServer/jenkins/master" },
  ]
}'''

// Uses the common library form 'https://github.com/icebear8/pipelineLibrary'
library identifier: 'common-pipeline-library@stable',
  retriever: modernSCM(github(
    id: '18306726-fec7-4d80-8226-b78a05add4d0',
    credentialsId: '3bc30eda-c17e-4444-a55b-d81ee0d68981',
    repoOwner: 'icebear8',
    repository: 'pipelineLibrary',
    traits: [
      [$class: 'org.jenkinsci.plugins.github_branch_source.BranchDiscoveryTrait', strategyId: 1],
      [$class: 'org.jenkinsci.plugins.github_branch_source.OriginPullRequestDiscoveryTrait', strategyId: 1],
      [$class: 'org.jenkinsci.plugins.github_branch_source.ForkPullRequestDiscoveryTrait', strategyId: 1, trust: [$class: 'TrustContributors']]]))

node {

  properties([
    pipelineTriggers([cron('H 15 * * 2')]),
    buildDiscarder(logRotator(
      artifactDaysToKeepStr: '5', artifactNumToKeepStr: '5',
      numToKeepStr: '5', daysToKeepStr: '5'))
  ])

  if(("${buildUtils.getCurrentBuildBranch()}" != "${repositoryUtils.getBranchLatest()}") ||
     ("${buildUtils.getCurrentBuildBranch()}".startsWith("${repositoryUtils.getBranchStable()}/") == false) ||
     ("${buildUtils.getCurrentBuildBranch()}".startsWith("${repositoryUtils.getBranchRelease()}/") == false)) {
    stage("Abort") {
      echo "Current branch: ${buildUtils.getCurrentBuildBranch()}"
      echo "Do not build branche with that naming schema: ${buildUtils.getCurrentBuildBranch()}"
    }
    currentBuild.result = 'ABORTED'
    return
  }

  repositoryUtils.checkoutCurrentBranch {
    stageName = 'Checkout'
    repoUrl = "${projectSettings.repository.url}"
    repoCredentials = "${projectSettings.repository.credentials}"
  }

  docker.withServer(env.DEFAULT_DOCKER_HOST_CONNECTION, 'default-docker-host-credentials') {
    try {
      stage("Build") {
        parallel dockerImage.setupBuildTasks {
          dockerRegistryUser = "${projectSettings.dockerHub.user}"
          buildJobs = projectSettings.dockerJobs
        }
      }
      stage("Push") {
        parallel dockerImage.setupPushTasks {
          dockerRegistryUser = "${projectSettings.dockerHub.user}"
          buildJobs = projectSettings.dockerJobs
        }
      }
    }
    finally {
      stage("Clean up") {
        parallel dockerImage.setupRemoveTasks {
          dockerRegistryUser = "${projectSettings.dockerHub.user}"
          buildJobs = projectSettings.dockerJobs
        }
      }
    }
  }
}
