package handler

import (
	"context"
	"encoding/json"
	"github.com/aws/aws-lambda-go/events"
)

type Response events.APIGatewayProxyResponse

type Handler interface {
	Run(ctx context.Context, event events.APIGatewayCustomAuthorizerRequest) (Response, error)
}

type lambdaHandler struct {
	randomName string
}

type LambdaResponse struct {
	Message string
}

func (l lambdaHandler) Run(ctx context.Context, event events.APIGatewayCustomAuthorizerRequest) (Response, error) {
	lambdaResponse := LambdaResponse{
		Message: "Hello " + l.randomName,
	}

	response, err := json.Marshal(lambdaResponse)

	res := Response{
		StatusCode:      200,
		IsBase64Encoded: false,
		Headers: map[string]string{
			"Access-Control-Allow-Origin":      "*",
			"Access-Control-Allow-Credentials": "true",
			"Cached-Control":                   "no-cache; no-store",
			"Content-Security-Policy":          "default-src 'self'",
			"Strict-Transport-Security":        "max-age=31536000; includeSubDomains",
			"X-Content-Type-Options":           "nosniff",
			"X-Frame-Options":                  "DENY",
			"X-XSS-Protetion":                  "1; mode=block",
			"Content-Type":                     "application/json",
		},
		Body: string(response),
	}

	return res, err

}

func NewLambdaHandler(randomName string) *lambdaHandler {
	return &lambdaHandler{
		randomName: randomName,
	}
}
