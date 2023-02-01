package style.model.dto;

public class Font {
	private int no;
	private int rnum;
	private String name;
	
	public Font() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Font(int no, String name) {
		super();
		this.no = no;
		this.name = name;
	}

	public Font(int no, int rnum, String name) {
		super();
		this.no = no;
		this.rnum = rnum;
		this.name = name;
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

	@Override
	public String toString() {
		return "Font [no=" + no + ", rnum=" + rnum + ", name=" + name + "]";
	}
	
}
