import { AuthGuard } from './../core/auth.guard';
import { Routes, RouterModule } from '@angular/router';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

const routes: Routes = [
  {
    path: '',
    loadChildren: () =>
      import('./pages/mes-scans/mes-scans.module').then(
        (m) => m.MesScansPageModule
      ),
    canActivate: [AuthGuard],
  },
  {
    path: 'recherche-scans',
    loadChildren: () =>
      import('./pages/recherche/recherche.module').then(
        (m) => m.RecherchePageModule
      ),
    canActivate: [AuthGuard],
  },
];

@NgModule({
  declarations: [],
  imports: [CommonModule, RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class MesScansModule {}
