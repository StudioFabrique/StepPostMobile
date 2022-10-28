import { RegexService } from './../../../core/services/regex.service';
import { InfosCourrier } from './../../../core/models/infos-courrier.model';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { NavController } from '@ionic/angular';

@Component({
  selector: 'app-scanner',
  templateUrl: './scanner.page.html',
  styleUrls: ['./scanner.page.scss'],
})
export class ScannerPage implements OnInit {
  displayQRCode!: boolean;
  courrier!: InfosCourrier;
  action!: boolean;
  form!: FormGroup;

  constructor(
    private formBuilder: FormBuilder,
    private regex: RegexService,
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
  }

  onQRCode() {
    this.displayQRCode = !this.displayQRCode;
  }

  onResult(value: string) {
    this.displayQRCode = false;
    this.nav.navigateBack(['/tabs/last-scan', value]);
  }
}
