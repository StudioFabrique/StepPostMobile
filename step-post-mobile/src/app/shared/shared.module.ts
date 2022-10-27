import { CardCourrierComponent } from './components/card-courrier/card-courrier.component';
import { FabComponent } from './components/fab/fab.component';
import { IonicModule } from '@ionic/angular';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule } from '@angular/forms';

@NgModule({
  declarations: [CardCourrierComponent, FabComponent],
  imports: [CommonModule, IonicModule.forRoot(), ReactiveFormsModule],
  exports: [ReactiveFormsModule, CardCourrierComponent, FabComponent],
})
export class SharedModule {}
