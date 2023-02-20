const userServiceOpenAPISpec = require(__dirname + '/../user-service/swagger.json')
const videoServiceOpenAPISpec = require(__dirname + '/../video-service/swagger.json')
const { merge, isErrorResult } = require('openapi-merge')
const { Swagger } = require('atlassian-openapi')
const fs = require('fs')

function main() {
    const mergeResult = merge([{
        oas: userServiceOpenAPISpec,
        pathModification: {
            prepend: ''
        }
    }, {
        oas: videoServiceOpenAPISpec,
        pathModification: {
            prepend: ''
        }
    }])

    if (isErrorResult(mergeResult)) {
        // Oops, something went wrong
        console.error(`${mergeResult.message} (${mergeResult.type})`)
    } else {
        console.log(`Merge successful!`);
        fs.writeFileSync(__dirname + '/../mergedOpenAPI.json', JSON.stringify(mergeResult.output, null, 2))
        console.log(JSON.stringify(mergeResult.output, null, 2))
    }
}

main()