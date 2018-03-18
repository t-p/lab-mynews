include .env

SCHEMA=`cat schema.graphql`

clean:
	rm -rf dist

dependencies:
	go get github.com/SlyMarbo/rss
	go get github.com/axgle/mahonia
	go get github.com/aws/aws-lambda-go/events
	go get github.com/aws/aws-lambda-go/lambda

build: clean
	GOOS=linux go build -o dist/handler ./...

configure:
	@aws s3api create-bucket \
		--profile $(PROFILE) \
		--bucket $(AWS_BUCKET_NAME) \
		--create-bucket-configuration LocationConstraint=eu-west-1

package: build
	@aws cloudformation package \
		--template-file template.yml \
		--profile $(PROFILE) \
		--s3-bucket $(AWS_BUCKET_NAME) \
		--region $(AWS_REGION) \
		--output-template-file package.yml

deploy:
	@aws cloudformation deploy \
		--template-file package.yml \
		--profile $(PROFILE) \
		--region $(AWS_REGION) \
		--capabilities CAPABILITY_IAM \
		--stack-name $(AWS_STACK_NAME)

describe:
	@aws cloudformation describe-stacks \
		--profile $(PROFILE) \
		--region $(AWS_REGION) \
		--stack-name $(AWS_STACK_NAME) 

outputs:
	@make describe | jq -r '.Stacks[0].Outputs'

local: build
	@aws-sam-local local invoke "Handler" \
		-e tests/cloud_watch_sample_event.json \
		--profile $(PROFILE) \

create-api:
	@aws appsync create-graphql-api \
		--name $(AWS_STACK_NAME) \
		--authentication-type API_KEY | jq

create-api-schema:
	@aws appsync start-schema-creation \
		--api-id $(API_ID) \
		--profile $(PROFILE) \
		--region $(AWS_REGION) \
		--definition "$(SCHEMA)" | jq

create-api-data-source:
	@aws appsync create-data-source \
		--api-id $(API_ID) \
		--profile $(PROFILE) \
		--region $(AWS_REGION) \
		--name myNews \
		--type AWS_LAMBDA \
		--service-role-arn $(ROLE) \
		--lambda-config "lambdaFunctionArn=$(LAMBDA)" | jq

create-api-resolver:
	@aws appsync create-resolver \
		--api-id $(API_ID) \
		--profile $(PROFILE) \
		--region $(AWS_REGION) \
		--type-name Query \
		--field-name feed \
		--data-source-name myNews \
		--request-mapping-template '{ "version" : "2017-02-28", "operation": "Invoke", "payload": $$util.toJson($$context.arguments) }' \
		--response-mapping-template '$$util.toJson($$context.result)' | jq

create-api-key:
	@aws appsync create-api-key \
		--api-id $(API_ID) | jq
