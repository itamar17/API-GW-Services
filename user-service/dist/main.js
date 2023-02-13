"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const core_1 = require("@nestjs/core");
const app_module_1 = require("./app.module");
const swagger_1 = require("@nestjs/swagger");
const fs = require("fs");
async function bootstrap() {
    const app = await core_1.NestFactory.create(app_module_1.AppModule);
    const config = new swagger_1.DocumentBuilder().setTitle('User-Service API').setDescription('API for User-Service').setVersion('1.0').build();
    const document = swagger_1.SwaggerModule.createDocument(app, config);
    fs.writeFileSync('./swagger.json', JSON.stringify(document));
    swagger_1.SwaggerModule.setup('api', app, document);
    await app.listen(4567);
}
bootstrap();
//# sourceMappingURL=main.js.map