import { RegexService } from './../../services/regex.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { InfosCourrier } from '../../models/infos-courrier.model';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { NavController } from '@ionic/angular';

@Component({
  selector: 'app-scanner',
  templateUrl: './scanner.page.html',
  styleUrls: ['./scanner.page.scss'],
})
export class ScannerPage implements OnInit {
  displaySaisie!: boolean;
  displayQRCode!: boolean;
  courrier!: InfosCourrier;
  action!: boolean;
  form!: FormGroup;

  constructor(
    private formBuilder: FormBuilder,
    private regex: RegexService,
    private router: Router,
    private nav: NavController
  ) {}

  ngOnInit() {
    this.form = this.formBuilder.group({
      bordereau: [
        null,
        [Validators.required, Validators.pattern(this.regex.numberRegex)],
      ],
    });
  }

  onSubmit(): void {
    if (this.form.valid) {
      this.onResult(this.form.value.bordereau);
    }
  }

  onAction() {
    this.action = true;
    console.log(this.action);
  }

  onQRCode() {
    this.displayQRCode = true;
    this.displaySaisie = false;
  }

  onResult(value: string) {
    this.displayQRCode = false;
    this.router.navigate(['/tabs/last-scan', value]);
  }

  onSaisie() {
    this.displayQRCode = false;
    this.displaySaisie = true;
  }
}
