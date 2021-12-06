pipeline {
    agent any
    stages {
        stage("release"){
            steps {
                sh '''
                    chmod +x ./addbranch.sh
                    sh ('./addbranch.sh ${version}')    
                }
        }
        stage ("build"){
            steps {
                sh '''
                    sudo docker build -t cowsay .
                    sudo docker run -p 4001:3001  -d cowsay 3001
                '''
            }
        }
        stage ("test"){
            steps {
                sh '''
                    sleep 10
                '''
            }
        }
        stage ("stop cowsay container"){
            steps {
                sh '''
                    sudo docker container rm -f cowsay
                '''
            }
        }
        stage ("publish") {
            steps {
                sh '''
                    sudo apt install awscli -y
                    aws configure set aws_access_key_id 
                    aws configure set aws_secret_access_key 
                    tag=$(head -n 1 tag.txt)  
                    git tag -a $tag -m $tag
                    git push origin $tag             
                    aws ecr-public get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin public.ecr.aws/c7o8u9c1
                    sudo docker tag cowsay:latest reem_version:latest public.ecr.aws/c7o8u9c1/reem_version:$tag
                    sudo docker push reem_version:latest public.ecr.aws/c7o8u9c1/reem_version:$tag   
                '''     
            }
        }
    }   
}