import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { LastScanPage } from './last-scan.page';

const routes: Routes = [
  {
    path: '',
    component: LastScanPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class LastScanPageRoutingModule {}
