import { FabComponent } from './components/fab/fab.component';
import { IonicModule } from '@ionic/angular';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule } from '@angular/forms';

@NgModule({
  declarations: [FabComponent],
  imports: [CommonModule, IonicModule.forRoot(), ReactiveFormsModule],
  exports: [ReactiveFormsModule, FabComponent],
})
export class SharedModule {}
