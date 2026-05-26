import os
import smtplib
from email.message import EmailMessage


def send_verification_email(to_email: str, token: str) -> None:
    public_backend_url = os.getenv("PUBLIC_BACKEND_URL", "http://127.0.0.1:8000")
    verify_url = f"{public_backend_url.rstrip('/')}/auth/verify-email?token={token}"

    smtp_host = os.getenv("SMTP_HOST")
    smtp_port = int(os.getenv("SMTP_PORT", "587"))
    smtp_user = os.getenv("SMTP_USER")
    smtp_password = os.getenv("SMTP_PASSWORD")
    smtp_from = os.getenv("SMTP_FROM", smtp_user or "no-reply@example.com")

    subject = "Bitte bestätige deine E-Mail-Adresse"
    body = f"""Hallo,

bitte bestätige deine E-Mail-Adresse, indem du diesen Link öffnest:

{verify_url}

Der Link ist zeitlich begrenzt gültig.

Falls du dich nicht registriert hast, kannst du diese E-Mail ignorieren.
"""

    if not smtp_host or not smtp_user or not smtp_password:
        print("E-Mail-Verifikation-Link:", verify_url)
        return

    message = EmailMessage()
    message["From"] = smtp_from
    message["To"] = to_email
    message["Subject"] = subject
    message.set_content(body)

    with smtplib.SMTP(smtp_host, smtp_port) as smtp:
        smtp.starttls()
        smtp.login(smtp_user, smtp_password)
        smtp.send_message(message)