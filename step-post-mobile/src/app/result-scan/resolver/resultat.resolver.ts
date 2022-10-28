import { RechercheService } from 'src/app/core/services/recherche.service';
import { InfosCourrier } from './../../core/models/infos-courrier.model';
import { Observable } from 'rxjs';
import { Injectable } from '@angular/core';
import {
  ActivatedRouteSnapshot,
  Resolve,
  RouterStateSnapshot,
} from '@angular/router';

@Injectable()
export class ResultatResolver implements Resolve<InfosCourrier> {
  constructor(private recherche: RechercheService) {}

  resolve(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<InfosCourrier> {
    const bordereau = route.paramMap.get('bordereau');
    return this.recherche.getCourrier(+bordereau);
  }
}
