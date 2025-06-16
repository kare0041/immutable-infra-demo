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
          # Create directory if it doesn't exist
          mkdir -p ~/.local/bin
          
          # Download Terraform
          curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
          
          # Remove existing terraform binary if it exists
          rm -f ~/.local/bin/terraform
          
          # Unzip with force flag
          unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip
          
          # Move to bin directory
          mv terraform ~/.local/bin/
          
          # Clean up
          rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
          
          # Add to PATH
          export PATH="$HOME/.local/bin:$PATH"
          
          # Verify installation
          terraform version
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
