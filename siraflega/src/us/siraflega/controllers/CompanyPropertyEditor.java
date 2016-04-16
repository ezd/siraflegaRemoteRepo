package us.siraflega.controllers;

import java.beans.PropertyEditorSupport;

import us.siraflega.entities.Company;

public class CompanyPropertyEditor extends PropertyEditorSupport {

	@Override
	public void setAsText(String text){
		Company company=new Company();
		company.setId(Integer.parseInt(text));
		setValue(company);
	}
}
