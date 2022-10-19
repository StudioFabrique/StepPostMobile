import { InfosCourrier } from './../../models/infos-courrier.model';
import { MesScansService } from './../../services/mes-scans.service';
import { UpdateStatutService } from './../../../core/services/update-statut.service';
import { AuthService } from 'src/app/core/services/auth.service';
import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-update-button',
  templateUrl: './update-button.component.html',
  styleUrls: ['./update-button.component.scss'],
})
export class UpdateButtonComponent implements OnInit {
  @Output() action = new EventEmitter<void>();
  @Input() etat!: any;
  @Input() courrier!: InfosCourrier;
  etats!: string[];

  constructor(
    private auth: AuthService,
    private mesScans: MesScansService,
    private updateService: UpdateStatutService
  ) {}

  ngOnInit() {}

  onUpdate() {
    this.updateService
      .updateStatut(this.etat.id, this.courrier.bordereau)
      .subscribe({
        next: this.handleUpdateStatutResponse.bind(this),
        error: this.auth.handleError.bind(this),
      });
  }
  private handleUpdateStatutResponse(response: any) {
    this.updateMesScans(response.data);
    this.action.emit();
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
