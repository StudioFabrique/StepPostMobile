import { MesScansService } from '../../../core/services/mes-scans.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-mes-scans',
  templateUrl: './mes-scans.page.html',
  styleUrls: ['./mes-scans.page.scss'],
})
export class MesScansPage implements OnInit {
  constructor(public mesScansService: MesScansService) {}

  /**
   * vérifie l'existence de la liste des scans du jour auprès du service,
   * sinon le service va la récupérer via une requête Http
   */

  ngOnInit() {
    if (!this.mesScansService.mesScans) {
      this.mesScansService.getScans();
    }
  }
}
