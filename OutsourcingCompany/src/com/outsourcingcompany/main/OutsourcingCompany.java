/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.outsourcingcompany.main;

import com.outsourcingcompany.view.*;
import java.sql.SQLException;
import java.text.ParseException;

public class OutsourcingCompany {
    public static void main(String[] args) throws SQLException, ParseException {
        // TODO code application logic here
        new LoginView().show();
    }
}
