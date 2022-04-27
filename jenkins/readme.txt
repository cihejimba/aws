# https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials-four-stage-pipeline.html

configuration de jenkins :
- installer le plugin AWS CodePipeline
- New Item => 	project name = "MyDemoProject"
		Freestyle project
		Cocher Execute concurrent builds if necessary
		Source Code Management = AWS CodePipeline
		Advanced > Provider = "MyJenkinsProviderName"
		Build Triggers = Poll SCM
		Schedule = * * * * *
		Build > Add build step > Execute shell "echo jenkins >> test-artifact.txt"
		Add post-build action = AWS CodePipeline Publisher
		Add Build Output Locations = vide pour avoir les valeurs par defaut

configuration de codepipeline stage build ou test :
- build stage = Add Jenkins
		Provider name = "MyJenkinsProviderName"
		Server URL = <dns de alb:8080>
		Project name = MyDemoProject

- deploy stage = choisir un bucket s3
		 verifier que test-artifact.txt a bien ete modifie par jenkins
		
