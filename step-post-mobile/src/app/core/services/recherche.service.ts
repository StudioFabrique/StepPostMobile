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
  etats!: string[];

  constructor(private http: HttpClient) {}

  getCourrier(bordereau: number): Observable<InfosCourrier> {
    return this.http
      .get<InfosCourrier>(
        `${environment.baseUrl}/facteur/courrier?bordereau=${bordereau}`
      )
      .pipe(
        tap((value) => {
          this.courrier = value;
        })
      );
  }

  getStatutsList(): Observable<any[]> {
    return this.http.get<any[]>(`${environment.baseUrl}/facteur/statuts`).pipe(
      tap((value) => {
        this.etats = value.map((elem) => elem.etat);
      })
    );
  }

  setType(type: number): string {
    let value;
    switch (type) {
      case 1:
        value = 'Lettre Suivie';
        break;
      case 0:
        value = 'Lettre RAR';
        break;
      default:
        value = 'Colis';
        break;
    }
    return value;
  }
}
