import { InfosCourrier } from '../models/infos-courrier.model';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class RechercheService {
  courrier!: InfosCourrier;
  etats!: any[];
  noResult!: string;

  constructor(private http: HttpClient) {}

  noResults(): Observable<any> {
    return this.http
      .get<any>(`https://api.npoint.io/3ddbced855639f012e06`)
      .pipe(tap((value: any) => (this.noResult = value.noResults)));
  }

  getCourrier(bordereau: number): Observable<InfosCourrier> {
    return this.http
      .get<InfosCourrier>(
        `${environment.baseUrl}/facteur/courrier?bordereau=${bordereau}`
      )
      .pipe(
        tap((value) => {
          if (value) {
            this.courrier = value;
          }
        })
      );
  }

  getStatutsList(): Observable<any[]> {
    return this.http.get<any[]>(`${environment.baseUrl}/facteur/statuts`).pipe(
      tap((value) => {
        this.etats = value;
        console.table(this.etats);
      })
    );
  }

  setEtat(value: number): string {
    const statut: any = this.etats.find(
      (item: any) => item.statutCode === value
    );
    return statut.etat;
  }

  setType(type: number): string {
    let value;
    switch (type) {
      case 1:
        value = 'Lettre RAR';
        break;
      case 0:
        value = 'Lettre Suivie';
        break;
      default:
        value = 'Colis';
        break;
    }
    return value;
  }
}
