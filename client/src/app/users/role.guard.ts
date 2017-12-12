import { Injectable } from '@angular/core';
import { Router, CanActivate } from '@angular/router';
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router/src/router_state';
import { User } from './user';

@Injectable()
export class RoleGuard implements CanActivate {

  private static readonly SYSADMIN_ROLE = 'SYSADMIN';
  private static readonly ADMIN_ROLE = 'ADMIN';
  private static readonly MANAGER_ROLE = 'MANAGER';
  private static readonly DISPATCHER_ROLE = 'DISPATCHER';
  private static readonly DRIVER_ROLE = 'DRIVER';
  private static readonly OWNER_ROLE = 'OWNER';

  constructor(private router: Router) {
    localStorage.removeItem('currentUser');
  }

  canActivate(route: ActivatedRouteSnapshot,
              state: RouterStateSnapshot): boolean {

    const currentUser = JSON.parse(localStorage.getItem('currentUser'));
    this.log(currentUser);
    if (currentUser) {
      return this.checkPermissions(currentUser, state);
    }

    // not logged in so redirect to login page
    this.log('User isn\'t singed in');
    this.router.navigate(['/auth']);
    return false;
  }

  private log(message: string) {
    console.log('AuthGuard: ' + message);
  }

  private checkPermissions(user: User, state: RouterStateSnapshot): boolean {
    let hasPermissions = false;

    this.log(`Routing state snapshot: ${state.url}`);
    switch (state.url) {
      case '/users': {
        hasPermissions = this.checkRole(user.roles, RoleGuard.OWNER_ROLE, RoleGuard.SYSADMIN_ROLE);
        break;
      }
      case '/waybills': {
        hasPermissions = this.checkRole(user.roles, RoleGuard.OWNER_ROLE, RoleGuard.MANAGER_ROLE, RoleGuard.DRIVER_ROLE);
        break;
      }
      case '/invoices': {
        hasPermissions = this.checkRole(user.roles, RoleGuard.OWNER_ROLE, RoleGuard.DISPATCHER_ROLE, RoleGuard.MANAGER_ROLE);
        break;
      }
    }
    return hasPermissions;
  }

  private checkRole(userRoles: string[], ...checkingRoles: string[]): boolean {
    return checkingRoles.some(role => userRoles.includes(role));
  }
}