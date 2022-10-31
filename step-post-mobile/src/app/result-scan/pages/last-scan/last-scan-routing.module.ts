import { ResultatResolver } from './../../resolver/resultat.resolver';
import { AuthGuard } from './../../../core/auth.guard';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { LastScanPage } from './last-scan.page';

const routes: Routes = [
  {
    path: '',
    component: LastScanPage,
    canActivate: [AuthGuard],
  },
  {
    path: ':bordereau',
    component: LastScanPage,
    canActivate: [AuthGuard],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class LastScanPageRoutingModule {}
