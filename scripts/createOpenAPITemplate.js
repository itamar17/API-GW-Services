const fs = require('fs')
const openAPI = require(__dirname + '/../mergedOpenAPI.json')
const domain = '${URL}'
// traverse the paths
for (let path of Object.keys(openAPI.paths)) {
    // traverse the methods
    for (let method of Object.keys(openAPI.paths[path])) {
        const port = path.includes('user') ? '4567' : '4568'
        openAPI.paths[path][method]['x-amazon-apigateway-integration'] = {
            httpMethod: method.toUpperCase(),
            payloadFormatVersion: "1.0",
            type: "HTTP_PROXY",
            uri: `${domain}:${port}${path}`,
        }

    }
    fs.writeFileSync(__dirname + '/../mergedOpenAPIExtended.json', JSON.stringify(openAPI, null, 2))
}