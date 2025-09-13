pipeline {
    agent any

    stages {
        stage('Restore dependencies') {
            steps {
                echo 'Restaurando dependencias de NuGet...'
                sh 'dotnet restore'
            }
        }
        stage('Build') {
            steps {
                echo 'Compilando el proyecto...'
                sh 'dotnet build --configuration Release'
            }
        }
        stage('Publish') {
            steps {
                echo 'Publicando el proyecto para despliegue...'
                sh 'dotnet publish --configuration Release --output ./publish'
            }
        }
    }
}