Create an .env file and add these two variables :
AWS_ACCESS_KEY_ID="YOUR_AWS_ACCESS_KEY_ID"
AWS_SECRET_ACCESS_KEY="YOUR_AWS_SECRET_ACCESS_KEY"

You should add the same variables to production/hello project in case you upload it to GitHub and you want the deploy workflow to work.

Just run:

```
terraform init 
To load all the necesary plugins
```
And then

```
terraform plan
```

To check what you've done

and then :

```
terraform apply
```

to deploy the infrastructure

```
terraform destroy
```

to destroy everything that was deployed
