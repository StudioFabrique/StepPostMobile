import { NavController } from '@ionic/angular';
import { Router } from '@angular/router';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-fab',
  templateUrl: './fab.component.html',
  styleUrls: ['./fab.component.scss'],
})
export class FabComponent implements OnInit {
  constructor(private nav: NavController) {}

  ngOnInit() {}

  onFabClick() {
    this.nav.navigateBack('/tabs/home');
  }
}
