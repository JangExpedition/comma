package style.model.dto;

public class Font {
	private int no;
	private int rnum;
	private String name;
	private String link;
	
	public Font() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Font(int no, String name, String link) {
		super();
		this.no = no;
		this.name = name;
		this.link = link;
	}

	public Font(int no, int rnum, String name, String link) {
		super();
		this.no = no;
		this.rnum = rnum;
		this.name = name;
		this.link = link;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	@Override
	public String toString() {
		return "Font [no=" + no + ", rnum=" + rnum + ", name=" + name + ", link=" + link + "]";
	}
	
}
