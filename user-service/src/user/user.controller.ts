import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import {User, UserService} from './user.service';

@Controller('v1/user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Get()
  async getUsers(): Promise<User[]> {
    return this.userService.getUsers();
  }

  @Get(':id')
  async getUserById(@Param('id') id: string): Promise<User> {
    return this.userService.getUserById(Number(id));
  }

  @Post()
  async addUser(@Body() body: { name: string; age: string }): Promise<User> {
    const { name, age } = body;
    return this.userService.addUser(name, Number(age));
  }
}
