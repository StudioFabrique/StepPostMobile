import { tap } from 'rxjs/operators';
import { environment } from './../../../environments/environment';
import { Observable } from 'rxjs';
import { MesScans } from './../models/mes-scans.model';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class MesScansService {
  mesScans!: MesScans[];

  constructor(private http: HttpClient) {}

  /**
   * récupère la liste des scans du jour effectué par l'utilisateur connecté
   *
   * @returns observable<MesScans[]>
   */

  getScans(): Observable<MesScans[]> {
    return this.http
      .get<MesScans[]>(`${environment.baseUrl}/facteur/mes-scans`)
      .pipe(tap((response) => (this.mesScans = response)));
  }

  updateMesScans(scan: MesScans) {
    if (!this.mesScans) {
      this.getScans().subscribe((response: MesScans[]) => this.addScan(scan));
    } else {
      this.addScan(scan);
    }
  }

  private addScan(scan: MesScans) {
    console.table(this.mesScans);

    this.mesScans = [...this.mesScans, scan];
  }
}
