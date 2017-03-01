package com.ailk.eaap.op2.conf.messageFlow.action;

public class TemplateModel {

	private String csv_template_id;
	private String csv_file_name;
	private String field_separator;
	private String quote_mark;
	private String first_line_type;
	private String file_add_date;
	private String date_format;
	private String separator_name_and_date;
	private String new_line_character;
	private String file_charset;

	public String getCsv_file_name() {
		return csv_file_name;
	}
	public void setCsv_file_name(String csv_file_name) {
		this.csv_file_name = csv_file_name;
	}
	public String getField_separator() {
		return field_separator;
	}
	public void setField_separator(String field_separator) {
		this.field_separator = field_separator;
	}
	public String getQuote_mark() {
		return quote_mark;
	}
	public void setQuote_mark(String quote_mark) {
		this.quote_mark = quote_mark;
	}
	public String getFile_add_date() {
		return file_add_date;
	}
	public void setFile_add_date(String file_add_date) {
		this.file_add_date = file_add_date;
	}
	public String getDate_format() {
		return date_format;
	}
	public void setDate_format(String date_format) {
		this.date_format = date_format;
	}
	public String getSeparator_name_and_date() {
		return separator_name_and_date;
	}
	public void setSeparator_name_and_date(String separator_name_and_date) {
		this.separator_name_and_date = separator_name_and_date;
	}
	public String getNew_line_character() {
		return new_line_character;
	}
	public void setNew_line_character(String new_line_character) {
		this.new_line_character = new_line_character;
	}
	public String getFile_charset() {
		return file_charset;
	}
	public void setFile_charset(String file_charset) {
		this.file_charset = file_charset;
	}
	public String getCsv_template_id() {
		return csv_template_id;
	}
	public void setCsv_template_id(String csv_template_id) {
		this.csv_template_id = csv_template_id;
	}
	public String getFirst_line_type() {
		return first_line_type;
	}
	public void setFirst_line_type(String first_line_type) {
		this.first_line_type = first_line_type;
	}
}
