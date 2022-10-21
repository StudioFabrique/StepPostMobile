import { UpdateStatutService } from './../../services/update-statut.service';
import { MesScansService } from './../../services/mes-scans.service';
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

  constructor(
    private auth: AuthService,
    private recherche: RechercheService,
    private mesScans: MesScansService,
    private updateService: UpdateStatutService
  ) {}

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

  onSignature(): void {
    this.signaturePad = !this.signaturePad;
  }

  onRetourSignature(value: any): void {
    this.signature = value;
    this.update(5, this.courrier.bordereau);
  }

  onUpdate(value: number) {
    if (value === 5) {
      this.signaturePad = true;
      return;
    } else {
      this.update(value, this.courrier.bordereau);
    }
  }

  private update(etat: number, bordereau: number): void {
    this.updateService.updateStatut(etat, bordereau).subscribe({
      next: this.handleUpdateStatutResponse.bind(this),
      error: this.auth.handleError.bind(this),
    });
  }

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

  private handleUpdateStatutResponse(response: any) {
    if (this.signature) {
      this.updateService
        .updateSignature(this.signature, this.courrier.id)
        .subscribe({
          next: this.handleUpdateSignatureResponse.bind(this),
          error: this.auth.handleError.bind(this),
        });
    }
    this.updateMesScans(response.data);
    this.action.emit();
  }

  private handleUpdateSignatureResponse(response: any) {
    console.log(response);
  }

  private updateMesScans(value: any) {
    const scan = {
      date: value.date,
      statutId: value.statutId,
      courrier: {
        id: value.id,
        bordereau: value.bordereau,
        type: this.courrier.type,
      },
    };
    this.mesScans.updateMesScans(scan);
  }
}
