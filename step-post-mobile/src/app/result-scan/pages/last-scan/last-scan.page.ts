import { HttpErrorResponse } from '@angular/common/http';
import { MesScansService } from './../../../core/services/mes-scans.service';
import { UpdateStatutService } from './../../../core/services/update-statut.service';
import { RechercheService } from './../../../core/services/recherche.service';
import { InfosCourrier } from './../../../core/models/infos-courrier.model';
import { AuthService } from 'src/app/core/services/auth.service';
import { ActivatedRoute } from '@angular/router';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-last-scan',
  templateUrl: './last-scan.page.html',
  styleUrls: ['./last-scan.page.scss'],
})
export class LastScanPage implements OnInit {
  courrier!: InfosCourrier;
  action!: boolean;
  showCancelLastActionBtn!: boolean;
  loader!: boolean;

  constructor(
    private route: ActivatedRoute,
    private auth: AuthService,
    private mesScansServices: MesScansService,
    public recherche: RechercheService,
    public updateService: UpdateStatutService
  ) {}

  ngOnInit() {
    this.loader = true;
    if (!this.route.snapshot.paramMap.get('bordereau')) {
      if (this.recherche.courrier) {
        this.courrier = this.recherche.courrier;
      }
    } else {
      this.getCourrier(+this.route.snapshot.paramMap.get('bordereau'));
    }
    if (!this.recherche.etats) {
      this.recherche.getStatutsList().subscribe();
    }
    if (!this.recherche.noResult) {
      this.recherche.noResults().subscribe();
    }
    this.loader = false;
  }

  onCancelLastAction(): void {
    this.updateService.deleteLastStatut(this.courrier.bordereau).subscribe({
      next: this.handleDeleteStatutResponse.bind(this),
    });
  }

  onRetour() {
    this.action = false;
  }

  /**
   * fait apparaître la modal avec les boutons d'ajout de statuts
   */
  onUpdate() {
    this.action = !this.action;
    if (!this.action) {
      this.getCourrier(this.courrier.bordereau);
      this.showCancelLastActionBtn = true;
    }
  }

  /**
   * fait disparaître la popup permettant de mettre à jour les statuts
   * et actualise le statut en cours
   */
  onUpdatedStatut() {
    this.action = false;
    this.getCourrier(this.courrier.bordereau);
  }

  /**
   * recherche un courrier dans la bdd
   *
   * @param bordereau number : numéro de courrier à récupérer dans la bdd
   */
  private getCourrier(bordereau: number) {
    this.loader = true;
    this.recherche.getCourrier(bordereau).subscribe({
      next: this.handleGetCourrierResponse.bind(this),
      error: this.handleError.bind(this),
    });
  }

  /**
   * Gestion de la réponse serveur
   *
   * @param response InfosCourrier
   */
  private handleGetCourrierResponse(response: InfosCourrier) {
    this.courrier = response;
    this.loader = false;
  }

  private handleError(error: any): void {
    if (error instanceof HttpErrorResponse) {
      if (error.status === 404) {
        this.loader = false;
      }
    }
  }

  /**
   * Gestion de la réponse serveur
   *
   * @param response String
   */
  private handleDeleteStatutResponse(response: string): void {
    this.showCancelLastActionBtn = false;
    this.getCourrier(this.courrier.bordereau);
    this.mesScansServices.deleteLastScan();
  }
}
