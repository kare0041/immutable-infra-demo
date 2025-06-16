pipeline {
  agent any

  environment {
    PATH = "/usr/local/bin:/usr/bin:/bin:$PATH"
    TF_VAR_subscription_id = credentials('AZURE_SUBSCRIPTION_ID')
    TF_VAR_admin_password  = credentials('VM_PASSWORD')
    TERRAFORM_VERSION = "1.5.7"
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
          mkdir -p ~/.local/bin
          curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
          unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
          mv terraform ~/.local/bin/
          rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
          export PATH="$HOME/.local/bin:$PATH"
        '''
      }
    }

    stage('Terraform Init') {
      steps {
        dir('terraform') {
          sh '''
            export PATH="$HOME/.local/bin:$PATH"
            terraform init
          '''
        }
      }
    }

    stage('Terraform Validate') {
      steps {
        dir('terraform') {
          sh '''
            export PATH="$HOME/.local/bin:$PATH"
            terraform validate
          '''
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        dir('terraform') {
          sh '''
            export PATH="$HOME/.local/bin:$PATH"
            terraform plan -out=tfplan
          '''
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        dir('terraform') {
          input message: 'Approve Terraform Apply?'
          sh '''
            export PATH="$HOME/.local/bin:$PATH"
            terraform apply -auto-approve tfplan
          '''
        }
      }
    }
  }
}
