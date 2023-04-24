package com.ktds.fr.common.util;

import com.google.gson.Gson;

public class ObjectUtils {

	private ObjectUtils() {}
	
	public static <T> T deepCopy(T source, Class<T> to) {
		Gson gson = new Gson();
		String json = gson.toJson(source);
		return gson.fromJson(json, to);
	}
	
}
