package share;

import member.MemberDTO;

public class RoomDTO {
	

	private int room_no;//게시판번호
	private int id_no; //외래키
	private String title;//제목
	private int view;//조회수
	private String address; //주소
	private String room_count; //방갯수
	private String room_option; //옵션
	private String fee; //요금
	private String room_info; //방정보
	private Double lat;//위도
	private Double lng;//경도
	private String filename; //파일
	private String fileRealname; //서버에 저장되는 실제이름
	

    public String getFilename() {
        return filename;
    }
    public void setFilename(String filename) {
        this.filename = filename;
    }
    public String getFileRealname() {
        return fileRealname;
    }
    public void setFileRealname(String fileRealname) {
        this.fileRealname = fileRealname;
    }
    public int getId_no() {
		return id_no;
	}
	public void setId_no(int id_no) {
		this.id_no = id_no;
	}
	public Double getLat() {
		return lat;
	}
	public void setLat(Double lat) {
		this.lat = lat;
		//System.out.println("값 확인=>"+lat);
	}
	public Double getLng() {
		return lng;
	}
	public void setLng(Double lng) {
		this.lng = lng;
		//System.out.println("값 확인=>"+lng);
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = convert(title);
	}
	public int getRoom_no() {
		return room_no;
	}
	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}
	public int getView() {
		return view;
	}
	public void setView(int view) {
		this.view = view;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = convert(address);
	}
	public String getRoom_count() {
		return room_count;
	}
	public void setRoom_count(String room_count) {
		this.room_count = convert(room_count);
	}
	public String getRoom_option() {
		return room_option;
	}
	public void setRoom_option(String room_option) {
		this.room_option = convert(room_option);
	}
	public String getFee() {
		return fee;
	}
	public void setFee(String fee) {
		this.fee = convert(fee);
	}
	public String getRoom_info() {
		return room_info;
	}
	public void setRoom_info(String room_info) {
		this.room_info = convert(room_info);
	}
	

	//이 클래스에서만 사용하기위해서 접근지정자 private <,>,(,)=>변경메서드
    private static String convert(String name) {
        if(name!=null){
            //2.입력받은 문자열중에서 자바스크립트 구문을 실행시킬수 있는 특수기호를 입력X(<,>)
            //문자열메서드->replaceAll(1.변경전문자열,2.변경후 문자열)
            
            name=name.replaceAll("<","&lt");
            name=name.replaceAll(">","&gt");
            //추가 eval(" " or ' ')
            name=name.replaceAll("\\(","&#40");
            name=name.replaceAll("\\)","&#41");
            //"test"  'test'
            name=name.replaceAll("\"","&quot");
            name=name.replaceAll("\'","&apos");
        }else{ //name==null
            return null; //입력을 하지 않았다면 더 이상 실행X
        }
        return name;
    }
}