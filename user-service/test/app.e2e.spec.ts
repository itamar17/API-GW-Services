import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from './../src/app.module';
import * as fs from "fs";
import { DocumentBuilder, SwaggerModule } from "@nestjs/swagger";

describe('AppController (e2e)', () => {
  let app: INestApplication;

  beforeEach(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();
  });

  it('should generate swagger spec', async () => {
    const config = new DocumentBuilder().setTitle('User-Service API').setDescription('API for User-Service').setVersion('1.0').build();

    const document = SwaggerModule.createDocument(app, config);
    fs.writeFileSync('./swagger.json', JSON.stringify(document));
  });
});
