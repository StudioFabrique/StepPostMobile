import { InfosCourrier } from '../../models/infos-courrier.model';
import { AuthService } from './../../../core/services/auth.service';
import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';
import { RechercheService } from 'src/app/core/services/recherche.service';

@Component({
  selector: 'app-update-statut',
  templateUrl: './update-statut.component.html',
  styleUrls: ['./update-statut.component.scss'],
})
export class UpdateStatutComponent implements OnInit {
  @Output() action = new EventEmitter<void>();
  @Input() courrier!: InfosCourrier;
  etats!: any[];
  actionsList!: any[];
  signaturePad!: boolean;
  signature!: any;

  constructor(private auth: AuthService, private recherche: RechercheService) {}

  ngOnInit() {
    if (!this.recherche.etats) {
      this.getEtats();
    } else {
      this.actionsList = this.setActionsList(this.recherche.etats);
    }
  }

  onAction() {
    this.action.emit();
  }

  onSignature() {}

  private handleGetEtatsResponse(response: any[]) {
    this.etats = response;
    this.actionsList = this.setActionsList(this.etats);
  }

  private getEtats() {
    this.recherche.getStatutsList().subscribe({
      next: this.handleGetEtatsResponse.bind(this),
      error: this.auth.handleError.bind(this),
    });
  }

  private setActionsList(etats: any[]): any[] {
    let tab = [];
    if (this.courrier.etat === 1) {
      tab = [...tab, { id: 2, etat: etats[1] }];
    } else {
      for (let i = 3; i < etats.length + 1; i++) {
        tab = [...tab, { id: i, etat: etats[i - 1] }];
      }
    }
    return tab;
  }
}
