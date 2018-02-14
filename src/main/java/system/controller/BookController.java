package system.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import system.model.Book;
import system.service.BookService;

import java.util.ArrayList;
import java.util.List;

@Controller
public class BookController {
    private BookService bookService;
    private static int id = 0;

    @Autowired(required = true)
    @Qualifier(value = "bookService")
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }


    @RequestMapping(value = "books/create", method = RequestMethod.POST)
    public String createBook(@ModelAttribute("book") Book book) {
        if (book.getId() == 0){
            this.bookService.createBook(book);
        } else {
            this.bookService.updateBook(book);
        }
        return "redirect:/";
    }


    @RequestMapping("/delete/{id}")
    public String deleteBook(@PathVariable("id") int id) {
        this.bookService.deleteBook(id);
        return "redirect:/";
    }


    @RequestMapping("/edit/{id}")
    public String editBook(@PathVariable("id") int id, Model model) {
        BookController.id = this.bookService.getBookById(id).getId();
        model.addAttribute("book", this.bookService.getBookById(id));
        model.addAttribute("listBooks", this.bookService.listBooks());
        Book book = this.bookService.getBookById(id);
        if (book.isReadAlready()) {
            book.setReadAlready(false);
            this.bookService.updateBook(book);
        }
        return "redirect:/";
    }

    @RequestMapping("/read/{id}")
    public String readBook(@PathVariable("id") int id, Model model) {
        model.addAttribute("book", this.bookService.getBookById(id));
        Book book = this.bookService.getBookById(id);
        if (!book.isReadAlready()) {
            book.setReadAlready(true);
            this.bookService.updateBook(book);
        }
        return "book";
    }

//    search & paging
    @RequestMapping(value = "/")
    public ModelAndView listOfBooks(@RequestParam(required = false) Integer page,
                                    @RequestParam(required = false) String bookTitle,
                                    @RequestParam(required = false) String yearFrom,
                                    @RequestParam(required = false) String yearTo) {

        ModelAndView modelAndView = new ModelAndView("index");
        if (id != 0) {
            modelAndView.addObject("book", this.bookService.getBookById(id));
            id = 0;
        } else {
            modelAndView.addObject("book", new Book());
        }

        List<Book> books = null;
        if (bookTitle == null || bookTitle.length() < 3) {
            books = this.bookService.listBooks();
        } else {
            List<Book> tmpBooks = this.bookService.listBooks();
            books = new ArrayList<Book>();
            for (Book tmpBook : tmpBooks) {
                if (tmpBook.getTitle().toLowerCase().contains(bookTitle.toLowerCase())) {
                    System.out.println("filter: " + tmpBook);
                    books.add(tmpBook);
                }
            }
        }

        int fromYear = 0;
        int toYear = 10000;

        if (yearFrom != null) {
            try {
                fromYear = Integer.parseInt(yearFrom);
            } catch (NumberFormatException e) {

            }
        }

        if (yearTo != null) {
            try {
                toYear = Integer.parseInt(yearTo);
            } catch (NumberFormatException e) {

            }
        }
        if (fromYear != 0 || toYear != 10000) {
            List<Book> tmpBooks = books;
            books = new ArrayList<Book>();
            for (Book tmpBook : tmpBooks) {
                if (tmpBook.getPrintYear() >= fromYear && tmpBook.getPrintYear() <= toYear) {
                    System.out.println("filter: " + tmpBook);
                    books.add(tmpBook);
                }
            }
        }

        PagedListHolder<Book> pagedListHolder = new PagedListHolder<Book>(books);
        pagedListHolder.setPageSize(10);
        modelAndView.addObject("maxPages", pagedListHolder.getPageCount());
        if (page == null || page < 1 || page > pagedListHolder.getPageCount()) {
            page  = 1;
        }
        modelAndView.addObject("page", page);
        if (page == null || page < 1 || page > pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(0);
            modelAndView.addObject("listBooks", pagedListHolder.getPageList());
        } else if (page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page - 1);
            modelAndView.addObject("listBooks", pagedListHolder.getPageList());
        }
        return modelAndView;
    }
}



