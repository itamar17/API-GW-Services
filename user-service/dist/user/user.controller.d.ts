import { User, UserService } from './user.service';
export declare class UserController {
    private readonly userService;
    constructor(userService: UserService);
    getUsers(): Promise<User[]>;
    getUserById(id: string): Promise<User>;
    addUser(body: {
        name: string;
        age: string;
    }): Promise<User>;
}
