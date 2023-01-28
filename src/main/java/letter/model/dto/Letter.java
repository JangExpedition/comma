package letter.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import common.Attachment;
import common.Form;
import common.OX;
import member.model.dto.MemberRole;

public class Letter extends Form{
	private String addressee;
	private int designNo;
	private int fontNo;
	private OX read_check;
	private String gender;
	private int age;
	private OX anonymous;
	private AF sendWho;
	private int attachCnt;
	private List<Attachment> attachments = new ArrayList<>();
	private MemberRole writerRole;
	
	public Letter() {
		super();
	}
	
	public Letter(int no, String writer, String content, Date regDate) {
		super(no, writer, content, regDate);
	}
	
	public Letter(int no, String writer, String addressee, int designNo, int fontNo, String content, Date regDate, 
			OX read_check, String gender, int age, OX anonymous, AF sendWho) {
		super(no, writer, content, regDate);
		this.addressee = addressee;
		this.designNo = designNo;
		this.fontNo = fontNo;
		this.read_check = read_check;
		this.gender = gender;
		this.age = age;
		this.anonymous = anonymous;
		this.sendWho = sendWho;
	}

	public Letter(int no, String writer, String addressee, int designNo, int fontNo, String content, Date regDate, 
			OX read_check, String gender, int age, OX anonymous, AF sendWho, int attachCnt, List<Attachment> attachments) {
		super(no, writer, content, regDate);
		this.addressee = addressee;
		this.designNo = designNo;
		this.fontNo = fontNo;
		this.read_check = read_check;
		this.gender = gender;
		this.age = age;
		this.anonymous = anonymous;
		this.sendWho = sendWho;
		this.attachCnt = attachCnt;
		this.attachments = attachments;
	}

	public Letter(String addressee, int designNo, int fontNo, OX read_check, String gender, int age, OX anonymous,
			AF sendWho, int attachCnt, List<Attachment> attachments, MemberRole writerRole) {
		super();
		this.addressee = addressee;
		this.designNo = designNo;
		this.fontNo = fontNo;
		this.read_check = read_check;
		this.gender = gender;
		this.age = age;
		this.anonymous = anonymous;
		this.sendWho = sendWho;
		this.attachCnt = attachCnt;
		this.attachments = attachments;
		this.writerRole = writerRole;
	}

	public Letter(int no, String writer, String content, Date regDate, String addressee, int designNo, int fontNo,
			OX read_check, String gender, int age, OX anonymous, AF sendWho, int attachCnt,
			List<Attachment> attachments, MemberRole writerRole) {
		super(no, writer, content, regDate);
		this.addressee = addressee;
		this.designNo = designNo;
		this.fontNo = fontNo;
		this.read_check = read_check;
		this.gender = gender;
		this.age = age;
		this.anonymous = anonymous;
		this.sendWho = sendWho;
		this.attachCnt = attachCnt;
		this.attachments = attachments;
		this.writerRole = writerRole;
	}

	public String getAddressee() {
		return addressee;
	}

	public void setAddressee(String addressee) {
		this.addressee = addressee;
	}

	public int getDesignNo() {
		return designNo;
	}

	public void setDesignNo(int designNo) {
		this.designNo = designNo;
	}

	public int getFontNo() {
		return fontNo;
	}

	public void setFontNo(int fontNo) {
		this.fontNo = fontNo;
	}

	public OX getRead_check() {
		return read_check;
	}

	public void setRead_check(OX read_check) {
		this.read_check = read_check;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public OX getAnonymous() {
		return anonymous;
	}

	public void setAnonymous(OX anonymous) {
		this.anonymous = anonymous;
	}

	public AF getSendWho() {
		return sendWho;
	}

	public void setSendWho(AF sendWho) {
		this.sendWho = sendWho;
	}

	public int getAttachCnt() {
		return attachCnt;
	}

	public void setAttachCnt(int attachCnt) {
		this.attachCnt = attachCnt;
	}

	public List<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}
	
	public MemberRole getWriterRole() {
		return writerRole;
	}

	public void setWriterRole(MemberRole writerRole) {
		this.writerRole = writerRole;
	}

	@Override
	public String toString() {
		return "Letter [addressee=" + addressee + ", designNo=" + designNo + ", fontNo=" + fontNo + ", read_check="
				+ read_check + ", gender=" + gender + ", age=" + age + ", anonymous=" + anonymous + ", sendWho="
				+ sendWho + ", attachCnt=" + attachCnt + ", attachments=" + attachments + ", writerRole=" + writerRole
				+ ", toString()=" + super.toString() + "]";
	}

	public void addAttachment(Attachment attach) {
		this.attachments.add(attach);
	} // addAttachment() end
}
