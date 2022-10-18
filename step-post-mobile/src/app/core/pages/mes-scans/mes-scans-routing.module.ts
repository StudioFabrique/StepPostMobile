import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { MesScansPage } from './mes-scans.page';

const routes: Routes = [
  {
    path: '',
    component: MesScansPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class MesScansPageRoutingModule {}
