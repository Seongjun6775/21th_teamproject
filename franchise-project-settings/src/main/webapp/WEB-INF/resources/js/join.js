/**
 * 
 */
document.addEventListener("DOMContentLoaded", function(){
	const signup = document.getElementById("sign-up");
	const signup2 = document.getElementById("sign-up2");
	const signin = document.getElementById("sign-in");
	const signin2 = document.getElementById("sign-in2");
	const findAcc = document.getElementById("find-account");
	const loginin = document.getElementById("login-in");
	const loginup = document.getElementById("login-up");
	const loginFind = document.getElementById("login-find");
		
		signup.addEventListener("click", () => {
		    loginin.classList.remove("block");
		    loginup.classList.remove("none");
		    loginFind.classList.remove("block");
		    
		
		    loginin.classList.add("none");
		    loginup.classList.add("block");
		    loginFind.classList.add("none");
		});
		
		signup2.addEventListener("click", () => {
		    loginin.classList.remove("block");
		    loginup.classList.remove("none");
		    loginFind.classList.remove("block");
		    
		
		    loginin.classList.add("none");
		    loginup.classList.add("block");
		    loginFind.classList.add("none");
		});
		
		signin.addEventListener("click", () => {
		    loginin.classList.remove("none");
		    loginup.classList.remove("block");
		    loginFind.classList.remove("block");
		    
		
		    loginin.classList.add("block");
		    loginup.classList.add("none");
		    loginFind.classList.add("none");
		});
		signin2.addEventListener("click", () => {
		    loginin.classList.remove("none");
		    loginup.classList.remove("block");
		    loginFind.classList.remove("block");
		    
		
		    loginin.classList.add("block");
		    loginup.classList.add("none");
		    loginFind.classList.add("none");
		});
		
		findAcc.addEventListener("click", () => {
			loginin.classList.remove("block");
			loginup.classList.remove("block");
		    loginFind.classList.remove("none");
		
		    loginin.classList.add("none");
		    loginup.classList.add("none");
		    loginFind.classList.add("block");
		});
});
