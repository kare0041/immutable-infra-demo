pipeline {
  agent any

  environment {
    PATH = "/usr/local/bin:/usr/bin:/bin:$PATH"
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
          # Create bin directory in user's home
          mkdir -p $HOME/bin
          
          # Download Terraform using curl
          curl -LO https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip
          
          # Extract Terraform
          unzip -o terraform_1.5.7_linux_amd64.zip
          
          # Move to user's bin directory
          mv terraform $HOME/bin/
          
          # Clean up
          rm terraform_1.5.7_linux_amd64.zip
          
          # Add to PATH
          export PATH="$HOME/bin:$PATH"
          
          # Verify installation
          $HOME/bin/terraform --version
        '''
      }
    }

    stage('Terraform Init') {
      steps {
        dir('terraform') {
          sh '''
            export PATH="$HOME/bin:$PATH"
            terraform init
          '''
        }
      }
    }

    stage('Terraform Validate') {
      steps {
        dir('terraform') {
          sh '''
            export PATH="$HOME/bin:$PATH"
            terraform validate
          '''
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        dir('terraform') {
          sh '''
            export PATH="$HOME/bin:$PATH"
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
            export PATH="$HOME/bin:$PATH"
            terraform apply -auto-approve tfplan
          '''
        }
      }
    }
  }
}