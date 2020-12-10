import { Injectable } from '@angular/core';
import {
  CanActivate,
  ActivatedRouteSnapshot,
  RouterStateSnapshot,
  Router,
  UrlTree,
} from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from '../auth.service';

@Injectable({
  providedIn: 'root',
})
export class AdminGuard implements CanActivate {
  constructor(private authService: AuthService, private route: Router) {}

  canActivate(
    // tslint:disable-next-line: max-line-length
    next: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ):
    | Observable<boolean | UrlTree>
    | Promise<boolean | UrlTree>
    | boolean
    | UrlTree {
    if (localStorage.getItem('rol') === 'A') {
      return true;
    } else {
      if (localStorage.getItem('rol') === 'I') {
        console.log('Estoy tratando de entrar como guarda a Admin');
        this.route.navigate(['/inicioInstru']);
        return false;
      } else {
        if (localStorage.getItem('rol') === 'G') {
          console.log('Estoy tratando de entrar como guarda a  Admin');
          this.route.navigate(['/inicioSegurityG']);
          return false;
        }
      }
      this.route.navigate(['/']);
      return false;
    }
  }
}
