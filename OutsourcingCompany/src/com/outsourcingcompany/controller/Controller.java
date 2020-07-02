/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.outsourcingcompany.controller;

import com.outsourcingcompany.model.Employee;
import com.outsourcingcompany.model.Client;
import com.outsourcingcompany.model.Job;
import com.outsourcingcompany.model.Project;
import com.outsourcingcompany.database.OracleConn;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Achmad Muchlasin
 */
public class Controller {

    OracleConn conn;

    ArrayList<Employee> arrEmployee;
    ArrayList<Client> arrClient;
    ArrayList<Job> arrJob;
    ArrayList<Project> arrProject;

    public Controller() throws SQLException {
        this.conn = new OracleConn();
        this.arrEmployee = new ArrayList<>();
        this.arrClient = new ArrayList<>();
        this.arrJob = new ArrayList<>();
        this.arrProject = new ArrayList<>();
    }

    public ArrayList<Employee> getEmployeeData() throws SQLException {
        this.arrEmployee.clear();
        ResultSet rs = this.conn.GetData("SELECT * FROM EMPLOYEE");
        while (rs.next()) {
            Employee emp = new Employee();
            emp.setEmpId(rs.getInt("ID_EMPLOYEE"));
            emp.setEmpName(rs.getString("EMPLOYEE_NAME"));
            emp.setEmpAddr(rs.getString("EMPLOYEE_ADDR"));
            emp.setEmpGender(rs.getString("GENDER"));
            emp.setEmpPhoneNo(rs.getString("PHONE_NO"));
            emp.setEmpEmail(rs.getString("EMAIL"));
            this.arrEmployee.add(emp);
        }

        return this.arrEmployee;
    }

    public ArrayList<Client> getClientData() throws SQLException {
        this.arrClient.clear();
        ResultSet rs = this.conn.GetData("SELECT * FROM CLIENT");
        while (rs.next()) {
            Client cl = new Client();
            cl.setClId(rs.getInt("ID_CLIENT"));
            cl.setClName(rs.getString("CLIENT_NAME"));
            cl.setClAddr(rs.getString("CLIENT_ADDR"));
            cl.setClEmail(rs.getString("CLIENT_EMAIL"));
            cl.setClPhoneNo(rs.getString("CLIENT_PHONE_NO"));
            this.arrClient.add(cl);
        }

        return this.arrClient;
    }

    public ArrayList<Job> getJobData() throws SQLException {
        this.arrJob.clear();
        ResultSet rs = this.conn.GetData("SELECT * FROM JOB JOIN CLIENT ON JOB.ID_CLIENT = CLIENT.ID_CLIENT");
        while (rs.next()) {
            Client cl = new Client();
            cl.setClId(rs.getInt("ID_CLIENT"));
            cl.setClName(rs.getString("CLIENT_NAME"));
            cl.setClAddr(rs.getString("CLIENT_ADDR"));
            cl.setClEmail(rs.getString("CLIENT_EMAIL"));
            cl.setClPhoneNo(rs.getString("CLIENT_PHONE_NO"));

            Job job = new Job();
            job.setJobId(rs.getInt("ID_JOB"));
            job.setClient(cl);
            job.setJobName(rs.getString("JOB_NAME"));
            job.setJobCat(rs.getString("CATEGORY"));
            job.setJobDesc(rs.getString("DESCRIPTION"));
            this.arrJob.add(job);
        }

        return this.arrJob;
    }
    
    public ArrayList<Job> getJobClientData() throws SQLException {
        this.arrJob.clear();
        ResultSet rs = this.conn.GetData("SELECT * FROM JOB_FROM_CLIENT_V");
        while (rs.next()) {
         Client cl = new Client();
            cl.setClId(rs.getInt("ID_CLIENT"));
            cl.setClName(rs.getString("CLIENT_NAME"));

            Job job = new Job();
            job.setJobId(rs.getInt("ID_JOB"));
            job.setClient(cl);
            job.setJobName(rs.getString("JOB_NAME"));
            job.setJobDesc(rs.getString("DESCRIPTION"));
            this.arrJob.add(job);
        }

        return this.arrJob;
    }

    public ArrayList<Project> getProjectData() throws SQLException {
        this.arrProject.clear();
        ResultSet rs = this.conn.GetData("SELECT PROJECT.ID_PROJECT, "
                + "JOB.JOB_NAME, EMPLOYEE.EMPLOYEE_NAME, PROJECT.START_DATE, "
                + "PROJECT.END_DATE FROM PROJECT JOIN JOB "
                + "ON PROJECT.ID_JOB = JOB.ID_JOB "
                + "JOIN EMPLOYEE ON PROJECT.ID_EMPLOYEE = EMPLOYEE.ID_EMPLOYEE "
                + "ORDER BY PROJECT.ID_PROJECT ASC");
        while (rs.next()) {
            Employee emp = new Employee();
            emp.setEmpName(rs.getString("EMPLOYEE_NAME"));

            Job job = new Job();
            job.setJobName(rs.getString("JOB_NAME"));

            Project project = new Project();
            project.setPrjId(rs.getInt("ID_PROJECT"));
            project.setJob(job);
            project.setEmployee(emp);
            project.setStartDate(rs.getDate("START_DATE"));
            project.setDueDate(rs.getDate("END_DATE"));

            this.arrProject.add(project);
        }
        return this.arrProject;
    }

    public void insertEmployee(Employee emp) {
        this.conn.ManipulasiData("INSERT INTO EMPLOYEE VALUES ('" + emp.getEmpId() + "', '" 
                + emp.getEmpName() + "', '" + emp.getEmpAddr() + "', '" 
                + emp.getEmpGender() + "', '" + emp.getEmpPhoneNo() + "', '" 
                + emp.getEmpEmail() + "')");
    }

    public void insertClient(Client cl) {
        this.conn.ManipulasiData("INSERT INTO CLIENT VALUES ('" + cl.getClId() + "', '" 
                + cl.getClName() + "', '" + cl.getClAddr() + "', '" 
                + cl.getClEmail() + "', '" 
                + cl.getClPhoneNo() + "')");
    }

    
    public void insertJob(Job job) {
        this.conn.ManipulasiData("INSERT INTO JOB VALUES ('" + job.getJobId() + "', '" 
                + job.getClient().getClId() + "', '" + job.getJobName() + "', '" 
                + job.getJobCat() + "', '" 
                + job.getJobDesc() + "')");
    }

    
    public void insertProject(Project project) {
        try {
            String startDate = new SimpleDateFormat("dd/MM/yyyy").format(project.getStartDate());
            String dueDate = new SimpleDateFormat("dd/MM/yyyy").format(project.getDueDate());
            this.conn.ManipulasiData("INSERT INTO PROJECT VALUES (ID_PROJECT.NEXTVAL, " 
                    + project.getJob().getJobId() + ", " 
                    + project.getEmployee().getEmpId() 
                    + ", TO_DATE('" + startDate + "', 'dd/MM/yyyy'), TO_DATE('" + dueDate + "', 'dd/MM/yyyy'))");
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    public void updateEmployee(Employee emp) {
        this.conn.ManipulasiData("UPDATE EMPLOYEE SET EMPLOYEE_NAME = '" + emp.getEmpName() 
                + "', EMPLOYEE_ADDR = '" + emp.getEmpAddr() 
                + "', GENDER = '" + emp.getEmpGender() 
                + "', PHONE_NO = '" + emp.getEmpPhoneNo() 
                + "', EMAIL = '" + emp.getEmpEmail() 
                + "' WHERE ID_EMPLOYEE = " + emp.getEmpId());
    }
    
    public void updateClient(Client cl) {
        this.conn.ManipulasiData("UPDATE CLIENT SET ID_CLIENT = " + cl.getClId() 
                + ", CLIENT_NAME = '" + cl.getClName() 
                + "', CLIENT_ADDR = '" + cl.getClAddr() 
                + "', CLIENT_EMAIL = '" + cl.getClEmail() 
                + "', CLIENT_PHONE_NO = '" + cl.getClPhoneNo() 
                + "' WHERE ID_CLIENT = " + cl.getClId());
    }
    
    public void updateJob(Job j) {
        this.conn.ManipulasiData("UPDATE JOB SET ID_CLIENT = " + j.getClient().getClId() 
                + ", JOB_NAME = '" + j.getJobName() 
                + "', CATEGORY = '" + j.getJobCat() 
                + "', DESCRIPTION = '" + j.getJobDesc() 
                + "' WHERE ID_JOB = " + j.getJobId());
    }

    public void updateProject(Project project) {
        String startDate = new SimpleDateFormat("dd/MM/yyyy").format(project.getStartDate());
        String dueDate = new SimpleDateFormat("dd/MM/yyyy").format(project.getDueDate());
        this.conn.ManipulasiData("UPDATE PROJECT SET ID_JOB = " + project.getJob().getJobId() 
                + ", ID_EMPLOYEE = " + project.getEmployee().getEmpId() 
                + ", START_DATE = TO_DATE('" + startDate 
                + "', 'dd/MM/yyyy'), END_DATE = TO_DATE('" + dueDate 
                + "', 'dd/MM/yyyy') WHERE ID_PROJECT = " + project.getPrjId()); 
    }
    
    public void deleteEmployee(Integer idEmp) {
        this.conn.ManipulasiData("DELETE FROM EMPLOYEE WHERE ID_EMPLOYEE = " + idEmp);
    }
    
    public void deleteClient(Integer idClient) {
        this.conn.ManipulasiData("DELETE FROM CLIENT WHERE ID_CLIENT = " + idClient);
    }
    
    public void deleteJob(Integer idJob) {
        this.conn.ManipulasiData("DELETE FROM JOB WHERE ID_JOB = " + idJob);
    }
    
    public void deleteProject(Integer Id) {
        this.conn.ManipulasiData("DELETE FROM PROJECT WHERE ID_PROJECT = " + Id);
    }
    

}
