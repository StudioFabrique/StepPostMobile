import { RegexService } from 'src/app/core/services/regex.service';
import { AuthService } from 'src/app/core/services/auth.service';
import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  styleUrls: ['./login.page.scss'],
})
export class LoginPage implements OnInit {
  form!: FormGroup;

  constructor(
    private auth: AuthService,
    private formBuilder: FormBuilder,
    private regex: RegexService,
    private router: Router
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
      this.auth.login('tata@toto.fr', '1234').subscribe({
        next: this.handleResponse.bind(this),
        error: this.handleError.bind(this),
      });
    }
  }

  handleError(error: any) {
    if (error instanceof HttpErrorResponse) {
      console.log(error);
    }
  }

  handleResponse(response: any) {
    if (response.token) {
      this.auth.token = response.token;
      this.auth.isLogged = true;
      this.router.navigateByUrl('/');
    }
  }
}
