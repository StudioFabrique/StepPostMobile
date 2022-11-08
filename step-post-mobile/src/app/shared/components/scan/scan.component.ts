import { RechercheService } from 'src/app/core/services/recherche.service';
import { MesScans } from '../../../core/models/mes-scans.model';
import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-scan',
  templateUrl: './scan.component.html',
  styleUrls: ['./scan.component.scss'],
})
export class ScanComponent implements OnInit {
  @Input() scan!: MesScans;

  constructor(public recherche: RechercheService) {}

  ngOnInit() {}

  setCardBgColor(statut: number): string {
    let color;
    switch (statut) {
      case 5:
        color = '#24A640';
        break;
      case 6:
        color = '#FF5E1A';
        break;
      case 7:
        color = '#FFCC40';
        break;
      case 8:
        color = '#FFCC40';
        break;
      default:
        color = '#';
    }
    return color;
  }

  setTextColor(statut: number): string {
    let color;
    switch (statut) {
      case 7:
        color = '#140a82';
        break;
      case 8:
        color = '#140a82';
        break;
      default:
        color = '#fff';
    }
    return color;
  }
}
