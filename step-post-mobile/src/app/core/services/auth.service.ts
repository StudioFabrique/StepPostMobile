import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  isLogged!: boolean;
  token!: string;

  constructor(private http: HttpClient, private router: Router) {}

  login(username: string, password: string): Observable<any> {
    return this.http.post<any>(`${environment.baseUrl}/auth/facteur/login`, {
      username,
      password,
    });
  }

  logout() {
    this.token = '';
    this.isLogged = false;
    this.router.navigateByUrl('/login');
  }

  getToken(): string {
    return this.token;
  }
}
