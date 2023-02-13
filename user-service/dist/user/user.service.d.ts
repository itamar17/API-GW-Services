export declare class User {
    readonly id: number;
    readonly name: string;
    readonly age: number;
    constructor(id: number, name: string, age: number);
}
export declare class UserService {
    private nextId;
    private users;
    getUsers(): User[];
    getUserById(id: number): User;
    addUser(name: string, age: number): User;
}
