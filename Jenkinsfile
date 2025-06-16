pipeline {
  agent any

  environment {
    PATH = "/opt/homebrew/bin:$PATH"  //
    TF_VAR_subscription_id = credentials('AZURE_SUBSCRIPTION_ID')
    TF_VAR_admin_password  = credentials('VM_PASSWORD')
  }

  stages {
    stage('Checkout Code') {
      steps {
        git url: 'https://github.com/kare0041/immutable-infra-demo.git', branch: 'main'
      }
    }

    stage('Install Terraform') {
      steps {
        sh '''
          wget https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip
          unzip terraform_1.5.7_linux_amd64.zip
          sudo mv terraform /usr/local/bin/
          rm terraform_1.5.7_linux_amd64.zip
        '''
      }
    }

    stage('Terraform Init') {
      steps {
        dir('terraform') {
          sh 'terraform init'
        }
      }
    }

    stage('Terraform Validate') {
      steps {
        dir('terraform') {
          sh 'terraform validate'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        dir('terraform') {
          sh 'terraform plan -out=tfplan'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        dir('terraform') {
          input message: 'Approve Terraform Apply?'
          sh 'terraform apply -auto-approve tfplan'
        }
      }
    }
  }
}
