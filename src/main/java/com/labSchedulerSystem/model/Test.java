package com.labSchedulerSystem.model;
import java.util.Date;




public class Test {
	private int testId;
    private TestType type;
    private String description;

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

	
	public enum TestType {
	    BLOOD_TEST("Blood Test"),
	    URINE_TEST("Urine Test"),
	    XRAY("X-Ray"),
	    ULTRASOUND("Ultrasound"),
	    MRI("MRI"),
	    CT_SCAN("CT Scan"),
	    ECG("Electrocardiogram"),
	    EEG("Electroencephalogram"),
	    EMG("Electromyogram"),
	    PFT("Pulmonary Function Test"),
	    COLONOSCOPY("Colonoscopy"),
	    ENDOSCOPY("Endoscopy"),
	    MAMMOGRAPHY("Mammography"),
	    PAP_SMEAR("Pap Smear"),
	    PSA_TEST("Prostate-Specific Antigen Test"),
	    TSH_TEST("Thyroid-Stimulating Hormone Test"),
	    LIPID_PROFILE("Lipid Profile"),
	    GLUCOSE_TEST("Glucose Test"),
	    HEMOGLOBIN_TEST("Hemoglobin Test"),
	    HIV_TEST("HIV Test");

	    private final String displayName;

	    TestType(String displayName) {
	        this.displayName = displayName;
	    }

	    public String getDisplayName() {
	        return displayName;
	    }
	}

	
}

