import { AuthService } from './auth.service';
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
  isLoading!: boolean;

  constructor(private auth: AuthService, private http: HttpClient) {}

  getScans(): void {
    this.getData();
  }

  updateMesScans(scan: MesScans) {
    if (!this.mesScans) {
      this.getData();
    } else {
      this.addScan(scan);
    }
  }

  getScanByBordereau(bordereau: number): Observable<any> {
    return this.http.get(
      `${environment.baseUrl}/facteur/recherche-scans?bordereau=${bordereau}`
    );
  }

  /**
   * retire le dernier élément du tableau mesScans
   * dans le cas ou l'utilisateur annule le dernier
   * scan effectué
   */
  deleteLastScan() {
    this.mesScans.pop();
  }

  private getData(): void {
    this.isLoading = true;
    this.handleScans().subscribe({
      next: this.handleResponse.bind(this),
      error: this.handleError.bind(this),
    });
  }

  private addScan(scan: MesScans) {
    this.mesScans = [...this.mesScans, scan];
  }

  private handleScans(): Observable<MesScans[]> {
    return this.http.get<any[]>(`${environment.baseUrl}/facteur/mes-scans`);
  }

  private handleResponse(response: MesScans[]) {
    this.mesScans = response;
    this.isLoading = false;
  }

  private handleError(error: any): void {
    this.isLoading = false;
    this.auth.logout();
  }
}
