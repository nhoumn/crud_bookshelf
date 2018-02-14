package system.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import system.dao.BookDao;
import system.model.Book;

import java.util.List;

@Service
public class BookServiceImpl implements BookService{

    private BookDao bookDao;

    public void setBookDao(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    @Transactional
    public void createBook(Book book) {
        this.bookDao.createBook(book);
    }

    @Transactional
    public void updateBook(Book book) {
        this.bookDao.updateBook(book);
    }

    @Transactional
    public void deleteBook(int id) {
        this.bookDao.deleteBook(id);
    }

    @Transactional
    public Book getBookById(int id) {
        return this.bookDao.getBookById(id);
    }

    @Transactional
    public List<Book> listBooks() {
        return this.bookDao.listBooks();
    }

}
