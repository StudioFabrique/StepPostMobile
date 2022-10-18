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
          import('../mes-scans/mes-scans.module').then(
            (m) => m.MesScansPageModule
          ),
        canActivate: [AuthGuard],
      },
      {
        path: 'scanner',
        loadChildren: () =>
          import('../scanner/scanner.module').then((m) => m.ScannerPageModule),
        canActivate: [AuthGuard],
      },
      {
        path: '',
        redirectTo: '/tabs/scanner',
        pathMatch: 'full',
      },
      {
        path: 'last-scan',
        loadChildren: () =>
          import('../last-scan/last-scan.module').then(
            (m) => m.LastScanPageModule
          ),
        canActivate: [AuthGuard],
      },
      {
        path: 'last-scan/:bordereau',
        loadChildren: () =>
          import('../last-scan/last-scan.module').then(
            (m) => m.LastScanPageModule
          ),
        canActivate: [AuthGuard],
      },
    ],
  },
  {
    path: '',
    redirectTo: '/tabs/scanner',
    pathMatch: 'full',
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
})
export class TabsPageRoutingModule {}
