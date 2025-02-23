import { Injectable } from '@angular/core';
import { User } from '../models/user.model';

@Injectable({ providedIn: 'root' })
export class UserService {
  private users: User[] = [];

  addUser(user: User): void {
    this.users.push(user);
    console.log('Usuário salvo:', user);
  }

  getUsers(): User[] {
    return this.users;
  }
}
