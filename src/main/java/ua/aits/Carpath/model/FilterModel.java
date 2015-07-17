/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.aits.Carpath.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import ua.aits.Carpath.functions.Constants;
import ua.aits.Carpath.functions.DB;

/**
 *
 * @author kiwi
 */
public class FilterModel {
    public Integer id;
    public String shortTitle;
    public String fullTitle;
    public Integer groupID;
    
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getShortTitle() {
        return shortTitle;
    }
    public void setShortTitle(String shortTitle) {
        this.shortTitle = shortTitle;
    }
    
    public String getFullTitle() {
        return fullTitle;
    }
    public void setFullTitle(String fullTitle) {
        this.fullTitle = fullTitle;
    }
    
    public Integer getGroupID() {
        return groupID;
    }
    public void setGroupID(Integer groupID) {
        this.groupID = groupID;
    }
    
    
    
    public List<FilterModel> getAllFilters() throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        ResultSet result = DB.getResultSet("select * from filters order by groupID;");
        List<FilterModel> resultList = new LinkedList<>();
        while (result.next()) {
            FilterModel temp = new FilterModel();
            temp.setId(result.getInt("id"));
            temp.setShortTitle(result.getString("title"));
            temp.setFullTitle(result.getString("descr"));
            temp.setGroupID(result.getInt("groupID"));
            resultList.add(temp);
        } 
        return resultList;
    }
    
    public String FiltersHTML(String id) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException{
        String resultHTML = "";
        for(FilterModel temp : getOneRowFilters(id)){
            if(temp.groupID > 0) {
                resultHTML += "<li>\n" +
"                            <div class=\"checkbox\">  \n" +
"                                <label class=\"\" >\n" +
"                                    <img src=\""+Constants.URL+"img/markers/"+temp.shortTitle+".png\"><input type=\"checkbox\" value=\""+temp.shortTitle+"\">"+temp.fullTitle+"\n" +
"                                </label>\n" +
"                            </div>\n" +
"                        </li> ";
            }
            else if(temp.groupID == -1) {
                
            }
            else if(temp.groupID == 0) {
                resultHTML += "<li>\n" +
"                            <div class=\"checkbox\">  \n" +
"                                <label class=\"double-point-filter\" >\n" +
"                                    <input type=\"checkbox\" value=\""+temp.shortTitle+"\">"+temp.fullTitle+"\n" +
"                                </label>\n" +
"                            </div>\n" +
"                        </li> ";
                    resultHTML += FiltersHTML(temp.id.toString());
            }
        }
        return resultHTML;
    }
    
    public List<FilterModel> getOneRowFilters(String id) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        ResultSet result = DB.getResultSet("select * from filters where groupID = "+id+" ORDER BY `sortNumber` ASC;");
        List<FilterModel> resultList = new LinkedList<>();
        while (result.next()) {
            FilterModel temp = new FilterModel();
            temp.setId(result.getInt("id"));
            temp.setShortTitle(result.getString("title"));
            temp.setFullTitle(result.getString("descr"));
            temp.setGroupID(result.getInt("groupID"));
            resultList.add(temp);
        } 
        return resultList;
    }
    
    
    public void addFilter(String title, String descr, String group_id) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        DB.runQuery("INSERT INTO `filters`(`title`, `descr`, `groupID`) VALUES ('"+title+"','"+descr+"',"+group_id+");");
    }
    
    public void deleteFilter(String id) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        DB.runQuery("DELETE FROM `filters` WHERE id="+id);
    }
    
    public String FiltersOnClick(String id) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException{
        ResultSet result = DB.getResultSet("select * from filters where groupID = "+id+";");
        String resultStr = "";
        while (result.next()) {
            resultStr +=",'"+result.getString("title")+"'";
        }
        return resultStr;
    }
    public String FiltersMain() throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException{
        ResultSet result = DB.getResultSet("select * from filters where groupID = 0;");
        String resultStr = "";
        while (result.next()) {
            resultStr +=",'"+result.getString("title")+"'";
            resultStr += this.FiltersOnClick(result.getString("id"));
        }
        return resultStr;
    }
    public String FiltersHTMLMap(String id) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException{
        String resultHTML = "";
        
        if("0".equals(id)){
            resultHTML = "<ul class='filtersMainContainer'>";
                Integer count = 1;
                for(FilterModel temp : getOneRowFilters(id)){
                    if(temp.id == 89) {
                        resultHTML += "<div class=\"filtersGreenIntend\"></div>";
                    }
                    resultHTML += "<li class=\"filterMap\"><input type=\"checkbox\" id=\""+temp.shortTitle+"\" class=\"css-checkbox\" checked=\"checked\" />\n" +
"                        <label for=\""+temp.shortTitle+"\" class=\"css-label\"\n" +
"                               onclick=\"Markers(['"+temp.shortTitle+"'"+this.FiltersOnClick(temp.id.toString())+"])\">"+temp.fullTitle+"</label>"
                            + "<a><div class=\"filterClickIntend\" onclick=\"rotateCaret('"+count+"')\"><div id=\"filtersCaret"+count+"\" class=\"bottom-caret\"></div></div></a>\n" +
"                    <ul>";
                    resultHTML += this.FiltersHTMLMap(temp.id.toString());
                    resultHTML += "</ul></li>";
                    count++;
                }
            resultHTML += "</ul>";
        }
        else {
            for(FilterModel temp : getOneRowFilters(id)){
                resultHTML += "<li class=\"subFilterMap\">\n" +
"                            <input type=\"checkbox\" id=\""+temp.shortTitle+"\" onclick=\"Markers(['"+temp.shortTitle+"'])\" class=\"css-checkbox\" checked=\"checked\" />"
                        + "<label for=\""+temp.shortTitle+"\" class=\"css-label\">"+temp.fullTitle+"</label>\n" +
"                        </li>";
            }
        }
        
        return resultHTML;
    }
    
}