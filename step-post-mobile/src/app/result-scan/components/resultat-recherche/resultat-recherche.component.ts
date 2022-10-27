import { InfosCourrier } from './../../../core/models/infos-courrier.model';
import { Component, Input, OnInit, EventEmitter, Output } from '@angular/core';
import { RechercheService } from 'src/app/core/services/recherche.service';

@Component({
  selector: 'app-resultat-recherche',
  templateUrl: './resultat-recherche.component.html',
  styleUrls: ['./resultat-recherche.component.scss'],
})
export class ResultatRechercheComponent implements OnInit {
  @Output() action = new EventEmitter<void>();
  @Input() courrier!: InfosCourrier;

  constructor(public recherche: RechercheService) {}

  ngOnInit() {
    if (!this.recherche.etats) {
      this.recherche.getStatutsList().subscribe();
    }
  }

  onUpdate() {
    this.action.emit();
  }
}
