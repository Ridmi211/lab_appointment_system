package com.labSchedulerSystem.model;

public class Test {
	private int testId;
	private TestType type;
	private String description;
	private String cost;
	private String reportReadyIn;
	private String PreparationInstructions;
	private String measurementUnit;
	private String lowReferenceRange;
	private String highReferenceRange;

	public Test(TestType type, String description) {
		this.type = type;
		this.description = description;
	}

	public TestType getType() {
		return type;
	}

	public void setType(TestType type) {
		this.type = type;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getTestId() {
		return testId;
	}

	public void setTestId(int testId) {
		this.testId = testId;
	}

	public String getReportReadyIn() {
		return reportReadyIn;
	}

	public void setReportReadyIn(String reportReadyIn) {
		this.reportReadyIn = reportReadyIn;
	}

	public String getMeasurementUnit() {
		return measurementUnit;
	}

	public void setMeasurementUnit(String measurementUnit) {
		this.measurementUnit = measurementUnit;
	}

	public String getLowReferenceRange() {
		return lowReferenceRange;
	}

	public void setLowReferenceRange(String lowReferenceRange) {
		this.lowReferenceRange = lowReferenceRange;
	}

	public String getHighReferenceRange() {
		return highReferenceRange;
	}

	public void setHighReferenceRange(String highReferenceRange) {
		this.highReferenceRange = highReferenceRange;
	}

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	public String getPreparationInstructions() {
		return PreparationInstructions;
	}

	public void setPreparationInstructions(String preparationInstructions) {
		PreparationInstructions = preparationInstructions;
	}

	public enum TestType {
		DEFAULT("Default"), BLOOD_TEST("Blood Test"), URINE_TEST("Urine Test"), XRAY("X-Ray"), ULTRASOUND("Ultrasound"),
		MRI("MRI"), CT_SCAN("CT Scan"), ECG("Electrocardiogram"), EEG("Electroencephalogram"), EMG("Electromyogram"),
		PFT("Pulmonary Function Test"), COLONOSCOPY("Colonoscopy"), ENDOSCOPY("Endoscopy"), MAMMOGRAPHY("Mammography"),
		PAP_SMEAR("Pap Smear"), PSA_TEST("Prostate-Specific Antigen Test"),
		TSH_TEST("Thyroid-Stimulating Hormone Test"), LIPID_PROFILE("Lipid Profile"), GLUCOSE_TEST("Glucose Test"),
		HEMOGLOBIN_TEST("Hemoglobin Test"), HIV_TEST("HIV Test");

		private final String displayName;

		TestType(String displayName) {
			this.displayName = displayName;
		}

		public String getDisplayName() {
			return displayName;
		}
	}

}
