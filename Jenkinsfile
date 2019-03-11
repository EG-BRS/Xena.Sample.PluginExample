node 
{ 
    def buildDetails = checkoutWithDetails(buildNumber:env.BUILD_NUMBER)

    stage('Build')
    {
        sh "dotnet restore src/Application.csproj --no-cache --source https://api.nuget.org/v3/index.json --source https://www.myget.org/F/brs-nuget/auth/3f890ec8-f492-4c79-a23b-357f124dbeec/api/v2"
        sh "dotnet build --no-cache -c Release src/Application.csproj"
    }

    buildDockerImage(buildDetails)
}
