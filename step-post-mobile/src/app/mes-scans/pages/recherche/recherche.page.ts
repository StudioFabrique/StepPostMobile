import { MesScans } from './../../../core/models/mes-scans.model';
import { AuthService } from 'src/app/core/services/auth.service';
import { MesScansService } from './../../../core/services/mes-scans.service';
import { ActivatedRoute } from '@angular/router';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-recherche',
  templateUrl: './recherche.page.html',
  styleUrls: ['./recherche.page.scss'],
})
export class RecherchePage implements OnInit {
  bordereau!: number;
  courrier!: any;
  mesScans!: MesScans[];

  constructor(
    private auth: AuthService,
    private route: ActivatedRoute,
    private mesScansService: MesScansService
  ) {}

  ngOnInit() {
    this.bordereau = +this.route.snapshot.paramMap.get('bordereau');
    this.mesScansService.getScanByBordereau(this.bordereau).subscribe({
      next: this.handleResponse.bind(this),
      error: this.auth.handleError.bind(this),
    });
  }

  private handleResponse(response: any): void {
    this.mesScans = response.sc.map((item) => ({
      date: item.date,
      statutId: item.statut_id,
      courrier: {
        id: response.id,
        bordereau: response.bordereau,
        type: response.type,
      },
    }));
  }
}
