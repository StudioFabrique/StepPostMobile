import { AuthGuard } from './../../../core/auth.guard';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { ScannerPage } from './scanner.page';

const routes: Routes = [
  {
    path: '',
    component: ScannerPage,
    canActivate: [AuthGuard],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ScannerPageRoutingModule {}
