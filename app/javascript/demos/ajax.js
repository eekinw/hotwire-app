// Select all links on the page
const links = document.querySelectorAll("a");

// Add a "click" event listener on each link to intercept the click
// and override the default behavior
links.forEach((link) => {
  link.addEventListener("click", (event) => {
    // Prevent the default link behavior (page reload)
    event.preventDefault();

    // Get the URL from the clicked link's href attribute
    const url = link.getAttribute("href");

    // Perform an AJAX request to fetch the new page's content
    fetch(url)
      .then((response) => {
        if (!response.ok) {
          throw new Error("Network response was not ok");
        }
        return response.text(); // Convert the response to text (HTML content)
      })
      .then((html) => {
        // Parse the response HTML and extract the new <body> content
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, "text/html");
        const newBody = doc.body;

        // Replace the current page's <body> with the new <body> from the response
        document.body.replaceWith(newBody);
      })
      .catch((error) => {
        console.error("There was a problem with the fetch operation:", error);
      });
  });
});

// disable turbo drive
{
  /* <a href="/" data-turbo="false">Disabled</a>

<form action="/messages" method="post" data-turbo="false">
</form>

<div data-turbo="false">
  <a href="/">Disabled</a>
  <form action="/messages" method="post">
  </form>
</div> */
}
