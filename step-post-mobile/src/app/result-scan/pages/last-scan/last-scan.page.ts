import { ResultatResolver } from './../../resolver/resultat.resolver';
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

  constructor(
    private route: ActivatedRoute,
    private auth: AuthService,
    public recherche: RechercheService,
    public updateService: UpdateStatutService
  ) {}

  ngOnInit() {
    this.courrier = this.route.snapshot.data.courrier;
    if (!this.recherche.etats) {
      this.recherche.getStatutsList().subscribe();
    }
  }

  /**
   * fait apparaître la modal avec les boutons d'ajout de statuts
   */
  onUpdate() {
    this.action = !this.action;
    if (!this.action) {
      this.getCourrier(this.courrier.bordereau);
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
    this.recherche.getCourrier(bordereau).subscribe({
      next: this.handleGetCourrierResponse.bind(this),
      error: this.auth.handleError.bind(this),
    });
  }

  private handleGetCourrierResponse(response: InfosCourrier) {
    this.courrier = response;
  }
}
