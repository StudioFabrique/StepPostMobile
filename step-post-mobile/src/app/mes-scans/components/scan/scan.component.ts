import { RechercheService } from 'src/app/core/services/recherche.service';
import { MesScans } from './../../../core/models/mes-scans.model';
import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-scan',
  templateUrl: './scan.component.html',
  styleUrls: ['./scan.component.scss'],
})
export class ScanComponent implements OnInit {
  @Input() scan!: MesScans;

  constructor(public recherche: RechercheService) {}

  ngOnInit() {
    if (!this.recherche.etats) {
      this.recherche.getStatutsList().subscribe();
    }
  }
}
