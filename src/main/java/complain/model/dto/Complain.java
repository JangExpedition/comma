package complain.model.dto;

import java.sql.Date;

import common.Form;

public class Complain extends Form{
	private String villain;
	private Partition partition;
	private int partitionNo;
	
	public Complain() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Complain(int no, String writer, String content, Date regDate) {
		super(no, writer, content, regDate);
		// TODO Auto-generated constructor stub
	}
	
	public Complain(String villain, Partition partition, int partitionNo) {
		super();
		this.villain = villain;
		this.partition = partition;
		this.partitionNo = partitionNo;
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
	
	@Override
	public String toString() {
		return "Complain [villain=" + villain + ", partition=" + partition + ", partitionNo=" + partitionNo
				+ ", toString()=" + super.toString() + "]";
	}
	
}
