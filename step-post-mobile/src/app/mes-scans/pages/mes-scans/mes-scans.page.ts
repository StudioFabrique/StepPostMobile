import { NavController } from '@ionic/angular';
import { RegexService } from 'src/app/core/services/regex.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MesScansService } from '../../../core/services/mes-scans.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-mes-scans',
  templateUrl: './mes-scans.page.html',
  styleUrls: ['./mes-scans.page.scss'],
})
export class MesScansPage implements OnInit {
  form!: FormGroup;
  timerOn!: boolean;

  constructor(
    public mesScansService: MesScansService,
    private formBuilder: FormBuilder,
    private regex: RegexService,
    private nav: NavController
  ) {}

  /**
   * vérifie l'existence de la liste des scans du jour auprès du service,
   * sinon le service va la récupérer via une requête Http
   */

  ngOnInit() {
    if (!this.mesScansService.mesScans) {
      this.mesScansService.getScans();
    }
    this.form = this.formBuilder.group({
      bordereau: [
        null,
        [Validators.required, Validators.pattern(this.regex.numberRegex)],
      ],
    });
  }

  onSubmit(): void {}
}
