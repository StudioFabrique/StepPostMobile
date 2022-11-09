import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class RegexService {
  //  regular expressions destinées à vérifier les formulaires de l'application

  mailRegex =
    // eslint-disable-next-line max-len
    /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  numberRegex = /^[0-9]*$/;
  passwordRegex =
    /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{10,})/;

  constructor() {}
}
