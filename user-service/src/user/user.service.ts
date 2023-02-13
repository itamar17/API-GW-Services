import { Injectable } from '@nestjs/common';
import { ApiProperty } from "@nestjs/swagger";

export class User {
  @ApiProperty()
  readonly id: number;
  @ApiProperty()
  readonly name: string;
  @ApiProperty()
  readonly age: number;
  constructor(id: number, name: string, age: number) {
    this.id = id;
    this.name = name;
    this.age = age;
  }
}

@Injectable()
export class UserService {
  private nextId = 3;
  private users: User[] = [
    new User(1, 'itamar', 32),
    new User(2, 'Nir', 15),
  ];

  getUsers(): User[] {
    return this.users;
  }

  getUserById(id: number): User {
    return this.users.filter((user) => user.id === id)[0];
  }

  addUser(name: string, age: number): User {
    const userToAdd = new User(this.nextId++, name, age);
    this.users.push(userToAdd);
    return userToAdd;
  }
}
