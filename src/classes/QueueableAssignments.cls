/**
 * Queueable apex class.
 */
public class QueueableAssignments implements Queueable {
	
	private List<Id> recordIds;
	private String objectName;

	public QueueableAssignments(List<Id> recordIds, String objectName) {
		this.recordIds = recordIds;
		this.objectName = objectName;
	}

	public void execute(QueueableContext context) {
        AssignmentUtil.rerun(recordIds, objectName);
	}
}