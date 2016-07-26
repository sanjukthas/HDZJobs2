package controllers;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.HdzApplicant;
import model.HdzEducation;
import model.HdzJobhistory;
import services.NewApplicantService;
import util.PasswordUtil;

/**
 * Servlet implementation class NewApplicant
 */
@WebServlet("/NewApplicant")
public class NewApplicant extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NewApplicant() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String bday = request.getParameter("dob");
		String veteran = request.getParameter("veteran");
		String citizen = request.getParameter("citizen");
		List<HdzEducation> edhist = new ArrayList<HdzEducation>();
		List<HdzJobhistory> jobhist = new ArrayList<HdzJobhistory>();

		for (int i = 1; i <= 3; i++) {
			HdzEducation edu = new HdzEducation();
			HdzJobhistory job = new HdzJobhistory();

			String schoolname = request.getParameter("edu" + i);
			String degree = request.getParameter("degree" + i);
			String datecomp = request.getParameter("date" + i);
			if (!schoolname.equals(null) && !degree.equals(null) && !datecomp.equals(null)) {
				edu.setDegreecompleted(degree);
				edu.setDatecompleted(datecomp);
				edu.setSchoolname(schoolname);
				edhist.add(edu);
			}
			String jobTitle = request.getParameter("job" + i);
			String company = request.getParameter("company" + i);
			String jobdesc = request.getParameter("jobdesc" + i);
			String startdate=request.getParameter("start"+i);
			String enddate=request.getParameter("leave"+i);
			if (!jobTitle.equals(null) && !company.equals(null) && !jobdesc.equals(null)) {
				job.setCompanyname(company);
				job.setDescription(jobdesc);
				job.setStartdate(startdate);
				job.setPosition(jobTitle);
				job.setEnddate(enddate);
				jobhist.add(job);
			}

		}

		String salt = PasswordUtil.getSalt();
		String hashedPwd = "";
		try {
			hashedPwd = PasswordUtil.hashPasswordPlusSalt(password, salt);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		HdzApplicant applicant = new HdzApplicant();
		applicant.setBday(bday);
		applicant.setEmail(email);
		applicant.setFirstname(firstname);
		applicant.setLastname(lastname);
		applicant.setHashedpwd(hashedPwd);
		applicant.setCitizen(citizen);
		applicant.setVeteran(veteran);
		applicant.setHdzEducations(edhist);
		applicant.setHdzJobhistories(jobhist);
		applicant.setSalt(salt);
		NewApplicantService.insertApplicant(applicant);
		String nextURL = "/login.jsp";
		request.getRequestDispatcher(nextURL).forward(request, response);
	}
	
	
	
}
