import { ToastController } from '@ionic/angular';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class ToasterService {
  constructor(private toastCtrl: ToastController) {}

  toast(msg: string, type: number): void {
    let classe: string;
    switch (type) {
      case 0:
        classe = 'error-toast';
        break;
      case 1:
        classe = 'warning-toast';
        break;
      default:
        classe = 'success-toast';
        break;
    }
    console.log(classe);

    this.toastCtrl
      .create({
        message: msg,
        duration: 2000,
        position: 'top',
        cssClass: [classe, 'toast'],
      })
      .then((toast) => toast.present());
  }

  loginSuccess(name: string): void {
    this.toast(`Bienvenue ${name}`, 2);
  }

  badCredentials(): void {
    this.toast('Identifiants incorrects !', 1);
  }

  deadToken(): void {
    this.toast('Jeton de session expiré, veuillez vous reconnecter', 0);
  }
}
