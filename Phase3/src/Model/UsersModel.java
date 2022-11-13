package Model;

import DTO.Users;
import View.Announcement;

import java.sql.*;


public class UsersModel {
    private final Announcement announcement;
    private UserAddressModel userAddressModel;
    private Oracle database;
    private int userCount;


    public UsersModel(Oracle database) throws SQLException {
        this.announcement = new Announcement();
        this.database = database;
    }

    public Users signUp(Users user) throws SQLException {
        String sql = "SELECT MAX(USER_ID) FROM USERS"; // 이렇게 하면 동시성 문제 있다는데 다른 방법도 알아봐야할듯?
        Statement stmt = this.database.getStatement();
        ResultSet rs = stmt.executeQuery(sql);
        int userCount = -1;
        while (rs.next()) {
            userCount = rs.getInt(1);
        }
        if (userCount >= 0) {
            String insertTemplate = "INSERT INTO USERS VALUES ( ?, ?, ?, ?, ?, ? )";
            PreparedStatement ps = this.database.getPreparedStatement(insertTemplate);
            ps.setInt(1, ++userCount); // User_ID
            ps.setString(2, user.username); // USER_NAME
            ps.setString(4, user.password); // PASSWORD
            ps.setString(3, user.dName); // DNAME
            ps.setString(5, user.phoneNumber); // PHONE_NUMBER
            ps.setString(6, "고마워요"); // Membership_tier
            int resInsert = ps.executeUpdate();
            if (resInsert == 1) {
                return new Users(userCount, user.username, user.dName, user.password, user.phoneNumber, "고마워요");
            }
        }
        return null;
    }

    public Users login(Users users) throws SQLException {
        String sql = "SELECT * FROM USERS WHERE User_Name=? AND Password=?";
        PreparedStatement ps = this.database.getPreparedStatement(sql);
        ps.setString(1, users.username);
        ps.setString(2, users.password);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int userId = rs.getInt(1);
            String userName = rs.getString(2);
            String dName = rs.getString(3);
            String password = rs.getString(4);
            String phoneNumber = rs.getString(5);
            String membershipTier = rs.getString(6);
            return new Users(userId, userName, dName, password, phoneNumber, membershipTier);

        } else {
            return null;
        }
        return new Users(this.);
    }

    public boolean isLogin() {
        return userId > 0;
    }

    public void profile() throws SQLException {
        String sql = "SELECT * from USERS WHERE USER_ID = ?";
        PreparedStatement ps = this.database.getPreparedStatement(sql);
        ps.setInt(1, this.userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            String userName = rs.getString(2);
            String dName = rs.getString(3);
            String password = rs.getString(4);
            String phoneNumber = rs.getString(5);
            String membershipTier = rs.getString(6);
            this.announcement.profile(
                userId,
                userName,
                dName,
                password,
                phoneNumber,
                membershipTier
            );
        }
    }

    public int getUserId() {
        return userId;
    }
}
