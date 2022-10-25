package tendency;

public class TendencyDTO {
	
	private int id_no;//아이디 일련번호
	private String starttime;//출근시간
	private String endtime;//퇴근시간
	private String sleeptime;//수면시간
	private String showertime;//샤워시간
	private String sleepinghabbit;//잠버릇
	private String smoking;//흡연유무
	private String pet;//반려동물유무
	
	public int getId_no() {
		return id_no;
	}
	public void setId_no(int id_no) {
		this.id_no = id_no;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getSleeptime() {
		return sleeptime;
	}
	public void setSleeptime(String sleeptime) {
		this.sleeptime = sleeptime;
	}
	public String getShowertime() {
		return showertime;
	}
	public void setShowertime(String showertime) {
		this.showertime = showertime;
	}
	public String getSleepinghabbit() {
		return sleepinghabbit;
	}
	public void setSleepinghabbit(String sleepinghabbit) {
		this.sleepinghabbit = sleepinghabbit;
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
	//모든 DTO클래스 뒤에  이 메서드 추가할 것
	//이 클래스에서만 사용하기위해서 접근지정자 private <,>,(,)=>변경메서드
	private static String convert(String name) {
		//1.null값을 체크하는 구문을 작성
		if(name!=null){
		//System.out.println("name=>"+name);
		//2.입력받은 문자열중에서 자바스크립트 구문을 실행할 수 있는 특수기호를 입력X(<,>)
		//문자열메서드->replaceAll(1.변경전문자열,2.변경후 문자열)
			name=name.replaceAll("<","&lt");
			name=name.replaceAll(">","&gt");
			//추가 eval(" " or ' ') ()
			name=name.replaceAll("(","&#40");
			name=name.replaceAll(")","&#41");
			//"test" 'test'
			name=name.replaceAll("\" ","&quot");
			name=name.replaceAll("\' ","&apos");
				
			System.out.println("name=>"+name);
		} else {
			return null;//입력을 하지 않았다면 더이상 실행X
		}
		return name;
	}
	
}
