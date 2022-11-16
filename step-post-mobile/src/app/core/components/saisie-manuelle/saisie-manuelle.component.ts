import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
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

  constructor(private formBuilder: FormBuilder, private regex: RegexService) {}

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
}
