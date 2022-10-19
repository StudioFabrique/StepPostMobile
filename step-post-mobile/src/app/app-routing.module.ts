import { CoreModule } from './core/core.module';
import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [];
@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules }),
    CoreModule,
  ],
  exports: [RouterModule],
})
export class AppRoutingModule {}
