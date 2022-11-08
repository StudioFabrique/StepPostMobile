import { AuthGuard } from './../../../core/auth.guard';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { RecherchePage } from './recherche.page';

const routes: Routes = [
  { path: '', component: RecherchePage, canActivate: [AuthGuard] },
  {
    path: ':bordereau',
    component: RecherchePage,
    canActivate: [AuthGuard],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class RecherchePageRoutingModule {}
