## meshblu-http-connector

A Meshblu connector for use in Octoblu or with other services.

Gateblu connector to make HTTP requests. Uses the [request](https://github.com/request/request) module.

### Setup Instructions

### Travis

1. `gem install travis`
1. `travis login`

#### Travis (S3)

For use if you need to push your browserified version

1. `travis encrypt [S3_ACCESS_KEY_SECRET]`
1. add the generated key to the .travis.yml file under `secret_access_key` in the s3 deploy section.
1. also add the s3 `access_key_id` to the same section

End result should look like this:

```yml
deploy:
  - provider: s3
    access_key_id: [S3_ACCESS_KEY]
    secret_access_key:
      secure: [S3_ACCESS_KEY_SECRET]
    bucket: [UPLOAD_BUCKET] # octoblu-cdn
    region: us-west-2
    skip_cleanup: true
    detect_encoding: true
    local-dir: deploy
    upload-dir: [UPLOAD_FOLDER] # js
    on:
      tags: true
      all_branches: true
      node: '0.10'
```

#### Travis (NPM Deploy)[http://docs.travis-ci.com/user/deployment/npm/]

1. `travis encrypt [NPM_ACCESS_KEY]` - this key is found in `~/.npmrc`
1. add the generated key to the .travis.yml file under `api_key` in the npm deploy section.
1. also add the npm `email` to the same section

End result should look like this:

```yml
deploy:
  - provider: npm
    skip_cleanup: true
    clean_up: false
    email: [NPM_EMAIL]
    api_key:
      secure: [NPM_ACCESS_KEY]
    on:
      tags: true
      all_branches: true
      node: '0.11'
```

### Usage

#### Message Schema
```json
{
  "options": {
    "method": "GET",
    "url": "http://192.168.0.5/status"
  }
}
```

#### Response
```json
{
  "devices": ["*"],
  "topic": "http-response",
  "payload": {
    "statusCode": 200,
    "body": {
      "online": true
    }
  }
}
```

#### Gateblu Installation

Use (gateblu)[https://gateblu.octoblu.com/] to run this as a device.

#### Manual Installation

1. `npm install meshblu-util -g`
1. `npm install meshblu-http-connector` or `git clone [GIT_URL]`
1. go into connector folder
1. `meshblu-util register -t device:meshblu-http-connector > meshblu.json`
1. `meshblu-util claim`
1. `npm start` or to start with debug `DEBUG='meshblu-http-connector*' npm start`


### Platform Dependencies

Edit the package.json to change the platformDependencies. This will show up when installing the connector in Octoblu and Gateblu.
