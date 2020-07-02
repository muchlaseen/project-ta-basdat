/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.outsourcingcompany.model;

/**
 *
 * @author Achmad Muchlasin
 */
public class Client {
    private Integer clId;
    private String clName;
    private String clAddr;
    private String clEmail;
    private String clPhoneNo;

    public Integer getClId() {
        return clId;
    }

    public void setClId(Integer clId) {
        this.clId = clId;
    }

    public String getClName() {
        return clName;
    }

    public void setClName(String clName) {
        this.clName = clName;
    }

    public String getClAddr() {
        return clAddr;
    }

    public void setClAddr(String clAddr) {
        this.clAddr = clAddr;
    }

    public String getClEmail() {
        return clEmail;
    }

    public void setClEmail(String clEmail) {
        this.clEmail = clEmail;
    }

    public String getClPhoneNo() {
        return clPhoneNo;
    }

    public void setClPhoneNo(String clPhoneNo) {
        this.clPhoneNo = clPhoneNo;
    }
    
    
}
