import { UpdateStatutService } from './../../../core/services/update-statut.service';
import { MesScansService } from './../../../core/services/mes-scans.service';
import { InfosCourrier } from './../../../core/models/infos-courrier.model';
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
  @Output() retour = new EventEmitter<void>();
  @Input() courrier!: InfosCourrier;
  actionsList!: any[];
  signaturePad!: boolean;
  signature!: any;
  showModal!: boolean;
  newStatut!: number | null;

  constructor(
    private auth: AuthService,
    public recherche: RechercheService,
    private mesScans: MesScansService,
    private updateService: UpdateStatutService
  ) {}

  ngOnInit() {
    if (!this.recherche.etats) {
      this.getEtats();
    } else {
      this.actionsList = this.setActionsList(this.recherche.etats);
      console.table(this.actionsList);
    }
  }

  onAction() {
    this.action.emit();
  }

  onResponse(value: boolean): void {
    if (!value) {
      this.showModal = false;
    } else {
      this.update(this.newStatut, this.courrier.bordereau);
    }
  }

  onRetour() {
    this.retour.emit();
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
      this.newStatut = value;
      this.showModal = true;
    }
  }

  private update(etat: number, bordereau: number): void {
    this.updateService.updateStatut(etat, bordereau).subscribe({
      next: this.handleUpdateStatutResponse.bind(this),
      error: this.auth.handleError.bind(this),
    });
  }

  private handleGetEtatsResponse(response: any[]) {
    this.actionsList = this.setActionsList(this.recherche.etats);
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
      tab = [...tab, { id: 2, etat: this.recherche.setEtat(2) }];
    } else {
      for (let i = 3; i < this.recherche.etats.length + 1; i++) {
        tab = [...tab, { id: i, etat: this.recherche.setEtat(i) }];
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
    console.log('response', response);

    this.newStatut = null;
    this.updateMesScans(response.data);
    this.action.emit();
  }

  private handleUpdateSignatureResponse(response: any) {
    console.log(response);
  }

  private updateMesScans(value: any) {
    console.log('value', value);

    const scan = {
      date: value.date,
      s: { statutCode: value.s.statutCode },
      courrier: {
        id: value.id,
        bordereau: value.bordereau,
        type: this.courrier.type,
      },
    };
    console.log('scan ', scan);
    this.mesScans.updateMesScans(scan);
  }
}
