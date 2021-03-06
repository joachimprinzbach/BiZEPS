#!/usr/bin/env groovy

def projectSettings = readJSON text: '''{
  "repository": {
    "url": "https://github.com/Zuehlke/BiZEPS.git",
    "credentials": "3bc30eda-c17e-4444-a55b-d81ee0d68981"
  },
  "dockerHub": {
    "user": "bizeps"
  },
  "dockerJobs": [
    {"imageName": "jenkins",        "dockerfilePath": "./buildServer/jenkins/master" },
    {"imageName": "certgenerator",  "dockerfilePath": "./utils/certGenerator"},
    {"imageName": "mcmatools",      "dockerfilePath": "./buildTools/mcmatools"},
  ]
}'''

// Uses the common library form 'https://github.com/icebear8/pipelineLibrary'
library identifier: 'common-pipeline-library@stable',
  retriever: modernSCM(
    [$class: 'GitSCMSource',
      remote: 'https://github.com/icebear8/pipelineLibrary',
      credentialsId: '3bc30eda-c17e-4444-a55b-d81ee0d68981',
      traits: [
        [$class: 'jenkins.plugins.git.traits.BranchDiscoveryTrait'],
        [$class: 'PruneStaleBranchTrait']]
    ])

node {
  def triggers = []
  if (repositoryUtils.isLatestBranch() == true) {
    triggers << cron('H 15 * * *')
  }

  properties([
    pipelineTriggers(triggers),
    buildDiscarder(logRotator(
      artifactDaysToKeepStr: '5', artifactNumToKeepStr: '5',
      numToKeepStr: '5', daysToKeepStr: '5'))
  ])

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
