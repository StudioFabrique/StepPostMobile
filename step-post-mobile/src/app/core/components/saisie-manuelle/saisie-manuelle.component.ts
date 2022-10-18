import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AuthService } from 'src/app/core/services/auth.service';
import { RechercheService } from 'src/app/core/services/recherche.service';
import { RegexService } from 'src/app/core/services/regex.service';

@Component({
  selector: 'app-saisie-manuelle',
  templateUrl: 'saisie-manuelle.component.html',
  styleUrls: ['saisie-manuelle.component.scss'],
})
export class SaisieManuelleComponent implements OnInit {
  @Output() resultat = new EventEmitter<string>();
  form!: FormGroup;
  noResults!: boolean;

  constructor(
    private auth: AuthService,
    private formBuilder: FormBuilder,
    private recherche: RechercheService,
    private regex: RegexService
  ) {}

  ngOnInit(): void {
    this.form = this.formBuilder.group({
      bordereau: [
        null,
        [Validators.required, Validators.pattern(this.regex.numberRegex)],
      ],
    });
  }

  onSubmit() {
    if (this.form.valid) {
      this.resultat.emit(this.form.value.bordereau);
    }
  }

  /*   handleError(error: any) {
    if (error instanceof HttpErrorResponse) {
      if (error.status === 401 || error.status === 403) {
        this.auth.logout();
      }
      if (error.status === 404) {
        this.noResults = true;
      }
    }
  }

  handleResponse(response: string) {
    this.noResults = false;
    console.log(response);
    this.recherche.lastScan = response;
    this.result.emit(response);
  } */
}
