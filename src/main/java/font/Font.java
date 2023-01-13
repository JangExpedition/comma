package font;

public class Font {
	private int no;
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

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
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
		return "Font [no=" + no + ", name=" + name + ", link=" + link + "]";
	}
	
}
