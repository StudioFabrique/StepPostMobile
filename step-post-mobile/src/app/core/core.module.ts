import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Routes, RouterModule } from '@angular/router';
import { HttpClientModule } from '@angular/common/http';
import { httpInterceptorProviders } from './interceptors';
import { QRScanner } from '@ionic-native/qr-scanner/ngx';

const routes: Routes = [
  {
    path: '',
    loadChildren: () =>
      import('./pages/tabs/tabs.module').then((m) => m.TabsPageModule),
  },
  {
    path: 'login',
    loadChildren: () =>
      import('../core/pages/login/login.module').then((m) => m.LoginPageModule),
  },
];

@NgModule({
  declarations: [],
  imports: [CommonModule, HttpClientModule, RouterModule.forChild(routes)],
  exports: [],
  providers: [QRScanner, httpInterceptorProviders],
})
export class CoreModule {}
