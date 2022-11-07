import { AuthService } from './auth.service';
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

  constructor(private auth: AuthService, private http: HttpClient) {}

  /**
   * récupère la liste des scans du jour effectué par l'utilisateur connecté
   *
   * @returns observable<MesScans[]>
   */

  getScans(): void {
    this.handleScans().subscribe({
      next: this.handleResponse.bind(this),
      error: this.auth.handleError.bind(this),
    });
  }

  updateMesScans(scan: MesScans) {
    if (!this.mesScans) {
      this.handleScans().subscribe((response: MesScans[]) => {
        this.mesScans = response;
      });
    } else {
      this.addScan(scan);
    }
  }

  /**
   * retire le dernier élément du tableau mesScans
   * dans le cas ou l'utilisateur annule le dernier
   * scan effectué
   */
  deleteLastScan() {
    this.mesScans.pop();
  }

  private addScan(scan: MesScans) {
    this.mesScans = [...this.mesScans, scan];
  }

  private handleScans(): Observable<MesScans[]> {
    return this.http.get<MesScans[]>(
      `${environment.baseUrl}/facteur/mes-scans`
    );
  }

  private handleResponse(response: MesScans[]) {
    this.mesScans = response;
  }
}
