import { Injectable } from '@angular/core';
import { CanActivate, Router, UrlSegmentGroup } from '@angular/router';
import { AuthService } from './services/auth.service';

@Injectable({
  providedIn: 'root',
})
export class AuthGuard implements CanActivate {
  constructor(public auth: AuthService, private router: Router) {}

  canActivate(): boolean {
    if (this.auth.isLogged) {
      return true;
    } else {
      this.auth.logout();
      return false;
    }
  }
}
