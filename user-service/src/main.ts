import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import * as fs from "fs";

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const config = new DocumentBuilder().setTitle('User-Service API').setDescription('API for User-Service').setVersion('1.0').build();

  const document = SwaggerModule.createDocument(app, config);
  fs.writeFileSync('./swagger.json', JSON.stringify(document));
  SwaggerModule.setup('user-service-api', app, document);
  await app.listen(4567);
}
bootstrap();
