import middy from '@middy/core'

function tokenBasedAuthorizer(event, context) {
    console.log('>>>>>>>>>>>>>>>>>>>>>>>>>\n', event)
    if (!event.authorizationToken) {
        throw 'Unauthorized'
    }

    // the return of this handler will be passed on to the lambda being invoked
    return Math.random() <  0.5 ? generateAllow('me', event.methodArn) : generateDeny('me', event.methodArn)
}

export const handler = middy(tokenBasedAuthorizer)

// Help function to generate an IAM policy
const generatePolicy = function(principalId, effect, resource) {
    // Required output:
    var authResponse = {}
    authResponse.principalId = principalId
    if (effect && resource) {
        var policyDocument = {}
        policyDocument.Version = '2012-10-17' // default version
        policyDocument.Statement = []
        var statementOne = {}
        statementOne.Action = 'execute-api:Invoke' // default action
        statementOne.Effect = effect
        statementOne.Resource = resource
        policyDocument.Statement[0] = statementOne
        authResponse.policyDocument = policyDocument
    }
    // Optional output with custom properties of the String, Number or Boolean type.
    authResponse.context = {
        "stringKey": "stringval",
        "numberKey": 123,
        "booleanKey": true
    }
    return authResponse
}

const generateAllow = function(principalId, resource) {
    return generatePolicy(principalId, 'Allow', resource)
}

const generateDeny = function(principalId, resource) {
    return generatePolicy(principalId, 'Deny', resource)
}
