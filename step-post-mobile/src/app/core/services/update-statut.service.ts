import { environment } from 'src/environments/environment';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class UpdateStatutService {
  action!: boolean;

  constructor(private http: HttpClient) {}

  updateStatut(state: number, bordereau: number): Observable<number> {
    return this.http.get<any>(
      `${environment.baseUrl}/facteur/update?bordereau=${bordereau}&state=${state}`
    );
  }

  updateSignature(signature: any, courrierId: number): Observable<any> {
    return this.http.put<any>(`${environment.baseUrl}/facteur/signature`, {
      courrierId,
      signature,
    });
  }

  deleteLastStatut(bordereau: number): Observable<string> {
    return this.http.delete<string>(
      `${environment.baseUrl}/facteur/statut?bordereau=${bordereau}`
    );
  }
}
