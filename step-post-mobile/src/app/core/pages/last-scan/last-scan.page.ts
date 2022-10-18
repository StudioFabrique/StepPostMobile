import { InfosCourrier } from '../../models/infos-courrier.model';
import { UpdateStatutService } from './../../services/update-statut.service';
import { AuthService } from 'src/app/core/services/auth.service';
import { RechercheService } from './../../services/recherche.service';
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
    if (!this.recherche.etats) {
      this.recherche.getStatutsList().subscribe();
    }
    const bordereau = this.route.snapshot.paramMap.get('bordereau');
    if (bordereau) {
      this.getCourrier(+bordereau);
    } else {
      console.log('oops');

      this.courrier = this.recherche.courrier;
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
