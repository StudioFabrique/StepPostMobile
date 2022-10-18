import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class RegexService {
  //  regular expressions destinées à vérifier les formulaires de l'application

  mailRegex =
    /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  numberRegex = /^[0-9]*$/;

  constructor() {}
}
