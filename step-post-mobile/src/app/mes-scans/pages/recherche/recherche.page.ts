import { ActivatedRoute } from '@angular/router';
import { MesScans } from './../../../core/models/mes-scans.model';
import { InfosCourrier } from './../../../core/models/infos-courrier.model';
import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-recherche',
  templateUrl: './recherche.page.html',
  styleUrls: ['./recherche.page.scss'],
})
export class RecherchePage implements OnInit {
  toto!: number;

  constructor(private route: ActivatedRoute) {}

  ngOnInit() {
    this.toto = +this.route.snapshot.paramMap.get('bordereau');
  }
}
