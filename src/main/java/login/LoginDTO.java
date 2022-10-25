package login;

public class LoginDTO {
    private int id_no;
	private String id;//회원 id
	private String password;//암호
	
	
	public int getId_no() {
        return id_no;
    }
    public void setId_no(int id_no) {
        this.id_no = id_no;
    }
    public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	
	
	
	
}
