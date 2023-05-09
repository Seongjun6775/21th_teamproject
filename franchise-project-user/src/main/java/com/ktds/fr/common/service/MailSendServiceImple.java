package com.ktds.fr.common.service;

import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.hr.vo.HrVO;
import com.ktds.fr.mbr.vo.MbrVO;

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
	
	@Override
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
	@Override
	public String makeEmailForm(String email) {
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
	@Override
	public void makeFindIdEmailForm(String email, List<MbrVO> mbrList) {
		String ids = "";
		for (MbrVO mbr : mbrList) {
			ids+=mbr.getMbrId() + "<br/>";
		}
		String from = "franchise.21th@gmail.com";
		String to = email;
		String title = projectName + " ID 찾기 이메일 답변.";
		String content =
				"<h1>"+projectName+"를 이용해 주셔서 감사합니다.</h1>" +"<br/><br/>" +
				"문의해주신 ID 찾기 결과는 <b><br/>";
		content += ids + "</b>입니다." +"<br/>";
		mailSend(from, to, title, content);
	}
	@Override
	public void makeFindPwEmailForm(MbrVO mbrVO) {
		String from = "franchise.21th@gmail.com";
		String to = mbrVO.getMbrEml();
		String title = projectName + " 비밀번호 찾기 이메일 답변.";
		String content =
				"<h1>"+projectName+"를 이용해 주셔서 감사합니다.</h1>" +"<br/><br/>" +
				mbrVO.getMbrId()+"님의 초기화된 비밀 번호는 <b>" + mbrVO.getMbrPwd() + "</b>입니다." +"<br>" +
				"로그인 후 꼭 비밀번호를 <span style='color: red;'>변경</span>해 주세요";
		mailSend(from, to, title, content);
	}
	
	@Override
	public void makeHrEamilForm(HrVO hrVO) {
		String from = "franchise.21th@gmail.com";
		String to = hrVO.getMbrVO().getMbrEml();
		String title = projectName + "지원하신 채용 결과";
		if(hrVO.getHrAprYn() != null && hrVO.getHrAprYn().length() != 0) {
			String content = 
					"<h1>"+projectName+"를 이용해 주셔서 감사합니다.</h1>" +"<br/><br/><b>" +
					(hrVO.getHrAprYn().equals("Y") ? "축하드립니다." : "죄송합니다.")+"</b><br/><br/>"+hrVO.getMbrVO().getMbrId()+"("+hrVO.getMbrVO().getMbrNm()+") 님은 "+
					"지원하신 <b>" +(hrVO.getHrLvl().equals("005-01") ? "가맹점주" : "점원")+ "</b> 분야에 <br/><b>"+(hrVO.getHrAprYn().equals("Y") ? "합격" : "불합격")+"</b> 하셨습니다.<br/>"+
					(hrVO.getHrAprYn().equals("Y") ? "합격자 일정은 추후 메일로 연락드리겠습니다. 다시한번 합격을 축하드립니다." : "이후 더욱 성장한 모습으로 다시금 만날 수 있기를 진심으로 바랍니다.");
			mailSend(from, to, title, content);
		}
	}
}
