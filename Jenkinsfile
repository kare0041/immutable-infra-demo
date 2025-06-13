pipeline {
  agent any

  stages {
    stage('Packer Build') {
      steps {
        sh '''
        packer build \
          -var "client_id=$CLIENT_ID" \
          -var "client_secret=$CLIENT_SECRET" \
          -var "tenant_id=$TENANT_ID" \
          -var "subscription_id=$SUBSCRIPTION_ID" \
          packer-template.json
        '''
      }
    }

    stage('Terraform Deploy') {
      steps {
        sh '''
        terraform init
        terraform apply -auto-approve
        '''
      }
    }
  }
}
