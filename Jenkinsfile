pipeline {
     // 定义本次构建使用哪个标签的构建环境
    agent any
    stages {
        // 拉取代码
        stage('Git Clone') {
            steps {
                git branch: '$Branch', credentialsId: 'gitlab-ssh-key', url: '$GitUrl'
            }
        }
        //获取配置文件
        stage('Pull Config'){
            steps{
                sh "wget http://192.168.2.40:9080/kubernetes-group/devops-gateway/-/raw/main/Dockerfile"
                sh "wget http://192.168.2.40:9080/kubernetes-group/devops-gateway/-/raw/main/deployment.yaml"
                sh "wget http://192.168.2.40:9080/kubernetes-group/devops-gateway/-/raw/main/entrypoint.sh"
                sh "wget http://192.168.2.40:9080/kubernetes-group/devops-gateway/-/raw/main/settings.xml"
                sh "wget http://192.168.2.40:9080/kubernetes-group/devops-gateway/-/raw/main/stop-java.sh"
                sh "wget http://192.168.2.40:9080/kubernetes-group/devops-gateway/-/raw/main/svc.yaml"
                sh "wget http://192.168.2.40:9080/kubernetes-group/devops-gateway/-/raw/main/configmap.yaml"
                sh 'sed -i "s#{appname}#${appname}#g" Dockerfile'
                sh 'sed -i "s#{Pserver}#${Pserver}#g" Dockerfile'
            }
         }
        //编译构建
        stage('Maven Compile Build'){
            steps{
                sh "mvn clean install -U --settings settings.xml -f $WORKSPACE/$PServer/$appname/pom.xml -Dmaven.test.skip=true "
            }
        }
        // 运行容器镜像构建和推送命令
        stage('Image Build And Publish'){
            steps{
                sh "docker login -u jenkins-test-user1 -p Test321654 ${HarborAddr}"
                sh 'pwd;ls;docker build -t ${HarborAddr}/${project}/${appname}:${tag} .'
                sh 'docker push ${HarborAddr}/${project}/${appname}:${tag}'
            }
        }
        //修改yaml文件相关参数
        stage('Set Yaml Param') {
            steps {
                sh 'sed -i "s#{num}#${num}#g" deployment.yaml'
                sh 'sed -i "s#{image}#${HarborAddr}/${project}/${appname}:${tag}#g" deployment.yaml'
                sh 'sed -i "s#{appname}#${appname}#g" deployment.yaml'
                sh 'sed -i "s#{appname}#${appname}#g" svc.yaml'
                sh 'sed -i "s#{appname}#${appname}#g" configmap.yaml'
                sh 'sed -i "s#{project}#${project}#g" deployment.yaml'
                sh 'sed -i "s#{project}#${project}#g" svc.yaml'
                sh 'sed -i "s#{project}#${project}#g" configmap.yaml'
                sh 'sed -i "s#{namespace}#${namespace}#g" deployment.yaml'
                sh 'sed -i "s#{namespace}#${namespace}#g" svc.yaml'
                sh 'sed -i "s#{namespace}#${namespace}#g" configmap.yaml'
                sh 'sed -i "s#{PORT}#${PORT}#g" deployment.yaml'
                sh 'sed -i "s#{SOPORT}#${SOPORT}#g" deployment.yaml'
                sh 'sed -i "s#{PORT}#${PORT}#g" svc.yaml'
                sh 'cat deployment.yaml'
                sh 'cat svc.yaml'
                sh 'cat configmap.yaml'
            }
        }
        // 发布
        stage('Deploy') {
            steps {
                sh '''
                pj_resu=`kubectl get cm  -n ${namespace} |grep ${appname}|wc -l`
                if [ $pj_resu -eq 0 ];then
                    kubectl apply -f  ${appname}.yaml -n ${namespace}
                fi
                pj_svc=`kubectl get svc -n ${namespace} |grep ${appname}|wc -l`
                if [ $pj_svc -eq 0 ];then
                    kubectl apply -f svc.yaml -n ${namespace}
                fi
                '''
                sh 'kubectl apply -f deployment.yaml -n ${namespace}'
              }

        }
    }

}
