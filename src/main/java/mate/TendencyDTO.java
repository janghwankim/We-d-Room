package mate;


public class TendencyDTO {

	private int id_no = 0;// 아이디일련번호
	private String Starttime = "";//출근시간
	private String endtime = "";//퇴근시간
	private String sleeptime = ""; //수면시간
	private String smoking = "";// 흡연유무
	private String pet = ""; //반려동물유무
	private String sleepinghabbit = "";//잠버릇
	private String showertime = "";//샤워시간

	
	//필터를 위해 추가 
	private String searchText = "";
	private String sleep ="" ;	
	
	
	
	public String getSleep() {
		return sleep;
	}
	public void setSleep(String sleep) {
		this.sleep = sleep;
	}
	

	public String getStarttime() {
		return Starttime;
	}
	public void setStarttime(String starttime) {
		Starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getSearchText() {
		return searchText;
	}
	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}
	public int getId_no() {
		return id_no;
	}
	public void setId_no(int id_no) {
		this.id_no = id_no;
	}
	public String getSleeptime() {
		return sleeptime;
	}
	public void setSleeptime(String sleeptime) {
		this.sleeptime = sleeptime;
	}
	public String getSmoking() {
		return smoking;
	}
	public void setSmoking(String smoking) {
		this.smoking = smoking;
	}
	public String getPet() {
		return pet;
	}
	public void setPet(String pet) {
		this.pet = pet;
	}
	
	public String getSleepinghabbit() {
		return sleepinghabbit;
	}
	public void setSleepinghabbit(String sleepinghabbit) {
		this.sleepinghabbit = sleepinghabbit;
	}
	public String getShowertime() {
		return showertime;
	}
	public void setShowertime(String showertime) {
		this.showertime = showertime;
	}
	
	
	
	
	
}
