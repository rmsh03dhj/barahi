const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "ap-southeast-2:bbae9d86-2ed6-42a9-9f46-f91d96ee1ea0",
                            "Region": "ap-southeast-2"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "ap-southeast-2_1j4CyNTi7",
                        "AppClientId": "62e0rrhdgebhdrrb61s4rlk50e",
                        "AppClientSecret": "1ugelfq5lgiprtu09fn8vn2hd7h632v0t32orikj1200mgptvud9",
                        "Region": "ap-southeast-2"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                }
            }
        }
    }
}''';