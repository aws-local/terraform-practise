node {
    git 'https://github.com/aws-local/content-terraform-docker-service.git'
    if(action == 'Deploy'){
        stage('init'){
            sh"""
                terraform init
            """
        }
        stage('plan'){
            sh label: 'terraform plan', script: 'terraform plan -out=tfplan -input=false -var ghost_image=${image_name} -var ghost_ext_port=${ghost_ext_port}'
            script {
                timeout(time: 10, unit: 'MINUTES'){
                    input(id: "Deploy Gate", message: 'Deploy Environment?',ok: 'Deploy')
                }
            }
        }
        stage('apply'){
            sh label: 'terraform apply', script: 'terraform apply -lock=false -input=false tfplan'
        }
    }

    if(action == 'Destroy'){
        stage('plan_destroy'){
            sh label: 'terraform plan destroy', script: "terraform plan -destroy -out=tfdestroyplan -input=false -var ghost_image=${image_name} -var ghost_ext_port=${ghost_ext_port}" 
        }
        stage('destroy'){
            script {
                timeout(time:10, unit:'MINUTES'){
                    input(id: "Destroy Gate", message: "Destroy environment?",ok: 'Destroy')
                }
            }
            sh label: 'Destroy environment', script: "terraform apply -lock=false -input=false tfdestroyplan"
        }
    }
}