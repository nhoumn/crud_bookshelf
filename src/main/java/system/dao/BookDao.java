package system.dao;

import system.model.Book;

import java.util.List;

public interface BookDao {
    public void createBook(Book book);

    public void updateBook(Book book);

    public void deleteBook(int id);

    public Book getBookById(int id);

    public List<Book> listBooks();
}
