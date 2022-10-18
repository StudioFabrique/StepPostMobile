import {
  HttpEvent,
  HttpHandler,
  HttpHeaders,
  HttpInterceptor,
  HttpRequest,
} from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from '../services/auth.service';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {
  token!: string;
  constructor(
    private authService: AuthService,
    private route: ActivatedRoute
  ) {}

  intercept(
    req: HttpRequest<any>,
    next: HttpHandler
  ): Observable<HttpEvent<any>> {
    this.token = this.authService.getToken();
    const headers = new HttpHeaders().append(
      'Authorization',
      `Bearer ${this.token}`
    );
    const modifiedReq = req.clone({ headers });
    return next.handle(modifiedReq);
  }
}
