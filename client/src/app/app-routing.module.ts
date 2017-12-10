import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AuthComponent } from './users/auth';
import { MainComponent } from './main';
import { AuthGuard } from './users';
import { RoleGuard } from './users';
import { UserListComponent } from './users/user-list';
import { InvoiceListComponent } from './invoices/invoice-list/invoice-list.component';
import { WaybillListComponent } from './waybills/waybill-list/waybill-list.component';

const routes: Routes = [
  {path: 'auth', component: AuthComponent},
  {
    path: '', component: MainComponent, data: {title: 'Trucking'}, canActivate: [AuthGuard],
     children: [
      {path: 'users', component: UserListComponent, data: {title: 'Users'}, canActivate: [RoleGuard] },
      {path: 'invoices', component: InvoiceListComponent, data: {title: 'Consignment notes'}, canActivate: [RoleGuard]},
      {path: 'waybills', component: WaybillListComponent, data: {title: 'Waybills'}, canActivate: [RoleGuard]},
    ]
  },
  {path: '**', redirectTo: ''}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
