package complain.model.dto;

import java.sql.Date;

import common.Form;

public class Complain extends Form{
	private String villain;
	private Partition partition;
	private int partitionNo;
	private int warningCnt;
	
	public Complain() {
		super();
	}
	
	public Complain(int no, String writer, String content, Date regDate) {
		super(no, writer, content, regDate);
	}
	
	public Complain(String villain, Partition partition, int partitionNo) {
		super();
		this.villain = villain;
		this.partition = partition;
		this.partitionNo = partitionNo;
	}
	
	public Complain(int no, String writer, String villain, Partition partition, String content, int partitionNo, Date regDate) {
		super(no, writer, content, regDate);
		this.villain = villain;
		this.partition = partition;
		this.partitionNo = partitionNo;
	}
	
	public Complain(int no, String writer, String content, Date regDate, String villain, Partition partition,
			int partitionNo, int warningCnt) {
		super(no, writer, content, regDate);
		this.villain = villain;
		this.partition = partition;
		this.partitionNo = partitionNo;
		this.warningCnt = warningCnt;
	}

	public String getVillain() {
		return villain;
	}

	public void setVillain(String villain) {
		this.villain = villain;
	}

	public Partition getPartition() {
		return partition;
	}

	public void setPartition(Partition partition) {
		this.partition = partition;
	}

	public int getPartitionNo() {
		return partitionNo;
	}

	public void setPartitionNo(int partitionNo) {
		this.partitionNo = partitionNo;
	}

	public int getWarningCnt() {
		return warningCnt;
	}

	public void setWarningCnt(int warningCnt) {
		this.warningCnt = warningCnt;
	}

	@Override
	public String toString() {
		return "Complain [villain=" + villain + ", partition=" + partition + ", partitionNo=" + partitionNo
				+ ", warningCnt=" + warningCnt + ", toString()=" + super.toString() + "]";
	}
	
}
