package notice;

import java.sql.Timestamp;

public class NoticeDTO {

    private int notice_no;
    private int id_no;
    private String id;
    private String title;
    private String content;
    private int views;
    private Timestamp created_datetime;
    
    
    
	public String getId() {
        return id;
    }


    public void setId(String id) {
        this.id = id;
    }


    public String getContent() {
        return content;
    }


    public void setContent(String content) {
        this.content = content;
    }


    public int getNotice_no() {
        return notice_no;
    }


    public void setNotice_no(int notice_no) {
        this.notice_no = notice_no;
    }


    public int getId_no() {
        return id_no;
    }


    public void setId_no(int id_no) {
        this.id_no = id_no;
    }


    public String getTitle() {
        return title;
    }


    public void setTitle(String title) {
        this.title = title;
    }


    public int getViews() {
        return views;
    }


    public void setViews(int views) {
        this.views = views;
    }


    public Timestamp getCreated_datetime() {
        return created_datetime;
    }


    public void setCreated_datetime(Timestamp created_datetime) {
        this.created_datetime = created_datetime;
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
