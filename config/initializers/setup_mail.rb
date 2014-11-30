ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: 'tictactoivo.com',
  user_name: 'tictactoivo@gmail.com',
  password: 'SimonSimon',
  authentication: "plain",
  enable: true,
  enable_starttls_auto: true
}
