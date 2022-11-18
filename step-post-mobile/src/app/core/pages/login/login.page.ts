import { ToasterService } from './../../services/toaster.service';
import { NavController } from '@ionic/angular';
import { RegexService } from 'src/app/core/services/regex.service';
import { AuthService } from 'src/app/core/services/auth.service';
import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  styleUrls: ['./login.page.scss'],
})
export class LoginPage implements OnInit {
  form!: FormGroup;
  isLoading!: boolean;

  constructor(
    private auth: AuthService,
    private formBuilder: FormBuilder,
    private nav: NavController,
    private regex: RegexService,
    private toaster: ToasterService
  ) {}

  ngOnInit() {
    this.form = this.formBuilder.group({
      email: [
        null,
        [Validators.required, Validators.pattern(this.regex.mailRegex)],
      ],
      password: [
        null,
        [Validators.required, Validators.pattern(this.regex.numberRegex)],
      ],
    });
  }

  onSubmit() {
    /* if (this.form.valid) */ {
      this.isLoading = true;
      this.auth.login('toto@tata.fr', '1234').subscribe({
        next: this.handleResponse.bind(this),
        error: this.handleError.bind(this),
      });
    }
  }

  handleResponse(response: any) {
    this.isLoading = false;
    if (response.token) {
      this.auth.token = response.token;
      this.auth.isLogged = true;
      this.nav.navigateRoot('/');
      this.nav.pop();
      this.toaster.loginSuccess(response.username);
    }
  }

  handleError(error: any) {
    this.isLoading = false;
    if (error instanceof HttpErrorResponse) {
      if (error.status === 401) {
        this.toaster.badCredentials();
      }
    }
  }
}
