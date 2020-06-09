class ReservationMailer < ApplicationMailer
  def reservation(book)
    @book = book
    @borrower = book.borrower
    @owner = book.user

    mail(to: "#{@owner.first_name} #{@owner.last_name} <#{@owner.email}>",
         subject: "Your book has been reserved by #{@borrower.first_name} #{@borrower.last_name}",
         template_name: 'reservation')
  end
end
