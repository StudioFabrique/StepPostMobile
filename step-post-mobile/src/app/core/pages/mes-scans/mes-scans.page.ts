import { MesScansService } from './../../services/mes-scans.service';
import { AuthService } from './../../services/auth.service';
import { MesScans } from './../../models/mes-scans.model';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-mes-scans',
  templateUrl: './mes-scans.page.html',
  styleUrls: ['./mes-scans.page.scss'],
})
export class MesScansPage implements OnInit {
  mesScans!: MesScans[];

  constructor(
    private auth: AuthService,
    private mesScansService: MesScansService
  ) {}

  /**
   * si le service est déjà instancié récupère la liste des scans,
   * sinon la récupère auprès de la bdd
   */

  ngOnInit() {
    if (this.mesScansService.mesScans) {
      this.mesScans = this.mesScansService.mesScans;
    } else {
      this.getMesScans();
    }
  }

  private handleResponse(response: MesScans[]) {
    this.mesScans = response;
  }

  /**
   * récupère la liste des scans du jour effectués par le facteur connecté
   */

  private getMesScans() {
    this.mesScansService.getScans().subscribe({
      next: this.handleResponse.bind(this),
      error: this.auth.handleError.bind(this),
    });
  }
}
