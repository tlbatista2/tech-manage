import { UserFormComponent } from './user-form.component';
import { UserService } from '../../services/user.service';
import { FormBuilder } from '@angular/forms';

describe('UserFormComponent', () => {
  let component: UserFormComponent;
  let service: UserService;

  beforeEach(() => {
    service = new UserService();
    component = new UserFormComponent(new FormBuilder(), service);
  });

  it('deve inicializar o formulário corretamente', () => {
    expect(component.userForm).toBeDefined();
  });

  it('deve adicionar um usuário válido', () => {
    component.userForm.setValue({
      name: 'João Silva',
      email: 'joao@email.com',
      phone: '11987654321',
      birthDate: '1990-01-01',
      userType: 'Administrador'
    });

    const spy = jest.spyOn(service, 'addUser');
    component.onSubmit();
    expect(spy).toHaveBeenCalled();
  });
});
