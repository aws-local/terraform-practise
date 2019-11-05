node {
    git 'https://github.com/aws-local/content-terraform-docker-secrets.git'
    if(action == 'Deploy'){
        stage('init'){
            sh"""
                terraform init
            """
        }
        stage('plan'){
            def ROOT_PASSWORD = sh (returnStdout: true, script: """echo ${mysql_root_password} | base64""").trim()
            def USER_PASSWORD = sh (returnStdout: true, script: """echo ${mysql_user_password} | base64""").trim()
            
            sh label: 'terraform plan', script: "terraform plan -out=tfplan -input=false -var mysql_root_password=${ROOT_PASSWORD} -var mysql_db_password=${USER_PASSWORD}"
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
            def ROOT_PASSWORD = sh (returnStdout: true, script: """echo ${mysql_root_password} | base64""").trim()
            def USER_PASSWORD = sh (returnStdout: true, script: """echo ${mysql_user_password} | base64""").trim()
            sh label: 'terraform plan destroy', script: "terraform plan -destroy -out=tfdestroyplan -input=false -var mysql_root_password=${ROOT_PASSWORD} -var mysql_db_password=${USER_PASSWORD}" 
        }
        stage('destroy'){
            script {
                timeout(time:10, unit:'MINUTES'){
                    input(id: "Destroy Gate", message: "Destroy environment?",ok: 'Destroy')
                }
            }
            sh label: 'Destroy environment', script: "terraform apply -lock=false -input=false tfdestroyplan"
        }
        stage('cleanup') {
             sh label: 'cleanup', script: "rm -rf terraform.tfstat"
    }
    }
}