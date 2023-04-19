package com.ktds.fr.common.service;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiStatus;

@Service
public class MailSendServiceImple implements MailSendService{

	@Autowired
	private JavaMailSenderImpl mailSender;
	private int authNumber;
	//TODO 변경사항
	private String projectName="Franchise";
	
	//난수 발생 메소드
	public void randomNumber() {
		// 난수 자릿수 8자리
		// 난수 범위 11111111~99999999
		Random random = new Random();
		int randomNumber = random.nextInt(99999999)+1;
		authNumber = randomNumber;
	}
	
	public void mailSend(String from, String to, String title, String content ) {
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(from);
			helper.setTo(to);
			helper.setSubject(title);
			//true 전달 > HTML형식으로 전달, 빼면 단순 텍스트 전달
			helper.setText(content, true);
			mailSender.send(message);
		} catch (MessagingException me) {
			throw new ApiException(ApiStatus.FAIL, "인증메일 전송에 실패하였습니다.");
		}
	}
	
	public String makeEamilForm(String email) {
		randomNumber();
		String from = "franchise.21th@gmail.com";
		String to = email;
		String title = projectName + "회원가입 인증 이메일.";
		String content =
				"<h1>"+projectName+"를 이용해 주셔서 감사합니다.</h1>" +"<br/><br/>" +
				"인증 번호는 <b>" + authNumber + "</b>입니다." +"<br>" +
				"위의 인증번호를 인증번호 확인란에 입력하세요.";
		mailSend(from, to, title, content);
		return Integer.toString(authNumber);
	}
	
}
