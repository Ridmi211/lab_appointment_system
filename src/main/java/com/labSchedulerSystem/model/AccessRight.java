package com.labSchedulerSystem.model;

public enum AccessRight {

	ROLE_USER("User"), ROLE_ADMIN("Admin"), ROLE_TECHNITIAN("Technitian");

	private final String displayName;

	AccessRight(String displayName) {
		this.displayName = displayName;
	}

	public String getDisplayName() {
		return displayName;
	}
}
