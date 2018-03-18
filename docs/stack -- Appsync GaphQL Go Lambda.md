

```bash
cd ../appsync-graphql-rss-proxy-go && ls -l
```

    total 28
    -rw-r--r-- 1 tp staff 3281 Mar 17 22:58 CODE_OF_CONDUCT.md
    -rw-r--r-- 1 tp staff 1094 Mar 17 22:58 LICENSE.md
    -rw-r--r-- 1 tp staff 1739 Mar 17 22:58 Makefile
    -rw-r--r-- 1 tp staff  694 Mar 17 22:58 README.md
    -rw-r--r-- 1 tp staff  648 Mar 17 22:58 main.go
    -rw-r--r-- 1 tp staff  112 Mar 17 22:58 schema.graphql
    -rw-r--r-- 1 tp staff 1319 Mar 17 23:13 template.yml



```bash
make configure
```

    {
        "Location": "http://lambda-rss-fetcher-cf-package-data.s3.amazonaws.com/"
    }



```bash
make package
```

    rm -rf dist
    GOOS=linux go build -o dist/handler ./...
    Uploading to b12da3b07b22f60a6fb1592ff9494909  3403496 / 3403496.0  (100.00%)
    Successfully packaged artifacts and wrote output template to file package.yml.
    Execute the following command to deploy the packaged template
    aws cloudformation deploy --template-file /Users/tp/blub/appsync-graphql-rss-proxy-go/package.yml --stack-name <YOUR STACK NAME>



```bash
make deploy
```

    
    Waiting for changeset to be created..
    Waiting for stack create/update to complete
    Successfully created/updated stack - lambda-rss-fetcher



```bash
make outputs
```

    [1;39m[
      [1;39m{
        [0m[34;1m"OutputKey"[0m[1;39m: [0m[0;32m"HandlerArn"[0m[1;39m,
        [0m[34;1m"OutputValue"[0m[1;39m: [0m[0;32m"arn:aws:lambda:eu-west-1:602660158150:function:lambda-rss-fetcher-Handler-1348W31Z0XVTC"[0m[1;39m,
        [0m[34;1m"Description"[0m[1;39m: [0m[0;32m"ARN for Go Handler"[0m[1;39m
      [1;39m}[0m[1;39m,
      [1;39m{
        [0m[34;1m"OutputKey"[0m[1;39m: [0m[0;32m"RoleArn"[0m[1;39m,
        [0m[34;1m"OutputValue"[0m[1;39m: [0m[0;32m"arn:aws:iam::602660158150:role/lambda-rss-fetcher-Role-1S8WIYSTRQFAT"[0m[1;39m,
        [0m[34;1m"Description"[0m[1;39m: [0m[0;32m"ARN for IAM Role"[0m[1;39m
      [1;39m}[0m[1;39m
    [1;39m][0m



```bash
make create-api
```

    [1;39m{
      [0m[34;1m"graphqlApi"[0m[1;39m: [0m[1;39m{
        [0m[34;1m"name"[0m[1;39m: [0m[0;32m"lambda-rss-fetcher"[0m[1;39m,
        [0m[34;1m"apiId"[0m[1;39m: [0m[0;32m"gcjh2mjkjfazdbbrs4ptqo25di"[0m[1;39m,
        [0m[34;1m"authenticationType"[0m[1;39m: [0m[0;32m"API_KEY"[0m[1;39m,
        [0m[34;1m"arn"[0m[1;39m: [0m[0;32m"arn:aws:appsync:eu-west-1:602660158150:apis/gcjh2mjkjfazdbbrs4ptqo25di"[0m[1;39m,
        [0m[34;1m"uris"[0m[1;39m: [0m[1;39m{
          [0m[34;1m"GRAPHQL"[0m[1;39m: [0m[0;32m"https://w3d52amjgzdxtkawdjpsbw4nbm.appsync-api.eu-west-1.amazonaws.com/graphql"[0m[1;39m
        [1;39m}[0m[1;39m
      [1;39m}[0m[1;39m
    [1;39m}[0m



```bash
make create-api-schema
```

    [1;39m{
      [0m[34;1m"status"[0m[1;39m: [0m[0;32m"PROCESSING"[0m[1;39m
    [1;39m}[0m



```bash
make create-api-data-source
```

    [1;39m{
      [0m[34;1m"dataSource"[0m[1;39m: [0m[1;39m{
        [0m[34;1m"dataSourceArn"[0m[1;39m: [0m[0;32m"arn:aws:appsync:eu-west-1:602660158150:apis/gcjh2mjkjfazdbbrs4ptqo25di/datasources/myNews"[0m[1;39m,
        [0m[34;1m"name"[0m[1;39m: [0m[0;32m"myNews"[0m[1;39m,
        [0m[34;1m"type"[0m[1;39m: [0m[0;32m"AWS_LAMBDA"[0m[1;39m,
        [0m[34;1m"serviceRoleArn"[0m[1;39m: [0m[0;32m"arn:aws:iam::602660158150:role/lambda-rss-fetcher-Role-1S8WIYSTRQFAT"[0m[1;39m,
        [0m[34;1m"lambdaConfig"[0m[1;39m: [0m[1;39m{
          [0m[34;1m"lambdaFunctionArn"[0m[1;39m: [0m[0;32m"arn:aws:lambda:eu-west-1:602660158150:function:lambda-rss-fetcher-Handler-1348W31Z0XVTC"[0m[1;39m
        [1;39m}[0m[1;39m
      [1;39m}[0m[1;39m
    [1;39m}[0m



```bash
make create-api-resolver
```

    [1;39m{
      [0m[34;1m"resolver"[0m[1;39m: [0m[1;39m{
        [0m[34;1m"typeName"[0m[1;39m: [0m[0;32m"Query"[0m[1;39m,
        [0m[34;1m"fieldName"[0m[1;39m: [0m[0;32m"feed"[0m[1;39m,
        [0m[34;1m"dataSourceName"[0m[1;39m: [0m[0;32m"myNews"[0m[1;39m,
        [0m[34;1m"resolverArn"[0m[1;39m: [0m[0;32m"arn:aws:appsync:eu-west-1:602660158150:apis/gcjh2mjkjfazdbbrs4ptqo25di/types/Query/resolvers/feed"[0m[1;39m,
        [0m[34;1m"requestMappingTemplate"[0m[1;39m: [0m[0;32m"{ \"version\" : \"2017-02-28\", \"operation\": \"Invoke\", \"payload\": $util.toJson($context.arguments) }"[0m[1;39m,
        [0m[34;1m"responseMappingTemplate"[0m[1;39m: [0m[0;32m"$util.toJson($context.result)"[0m[1;39m
      [1;39m}[0m[1;39m
    [1;39m}[0m



```bash
make create-api-key
```

    [1;39m{
      [0m[34;1m"apiKey"[0m[1;39m: [0m[1;39m{
        [0m[34;1m"id"[0m[1;39m: [0m[0;32m"da2-iztsic4u7jct7n4wsz53ovcujq"[0m[1;39m,
        [0m[34;1m"expires"[0m[1;39m: [0m[0;39m1521932400[0m[1;39m
      [1;39m}[0m[1;39m
    [1;39m}[0m

