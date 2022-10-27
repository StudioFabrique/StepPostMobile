import { RechercheService } from './../../../core/services/recherche.service';
import { InfosCourrier } from './../../../core/models/infos-courrier.model';
import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-card-courrier',
  templateUrl: './card-courrier.component.html',
  styleUrls: ['./card-courrier.component.scss'],
})
export class CardCourrierComponent implements OnInit {
  @Input() courrier!: InfosCourrier;

  constructor(public recherche: RechercheService) {}

  ngOnInit() {}
}
