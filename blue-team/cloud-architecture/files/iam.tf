resource "aws_iam_role" "TestIAMRole" {
  name               = "serverless_lambda"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }]
})
}

resource "aws_iam_role_policy_attachment" "TestIARMRole" {
  role       = aws_iam_role.TestIAMRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}