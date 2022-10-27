import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from '../../auth.guard';
import { TabsPage } from './tabs.page';

const routes: Routes = [
  {
    path: 'tabs',
    component: TabsPage,
    children: [
      {
        path: 'mes-scans',
        loadChildren: () =>
          import('../../../mes-scans/mes-scans.module').then(
            (m) => m.MesScansModule
          ),
        canActivate: [AuthGuard],
      },
      {
        path: 'home',
        loadChildren: () =>
          import('../../../home/home.module').then((m) => m.HomeModule),
        canActivate: [AuthGuard],
      },
      {
        path: '',
        redirectTo: '/tabs/home',
        pathMatch: 'full',
      },
      {
        path: 'last-scan',
        loadChildren: () =>
          import('../../../result-scan/result-scan.module').then(
            (m) => m.ResultScanModule
          ),
        canActivate: [AuthGuard],
      },
    ],
  },
  {
    path: '',
    redirectTo: '/tabs/home',
    pathMatch: 'full',
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
})
export class TabsPageRoutingModule {}
