import * as ActiveStorage from "@rails/activestorage";
import Rails from "@rails/ujs";
import * as Channels from "channels";
import Turbolinks from "turbolinks";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import MenuHamburger from "src/menu_hamburger";

document.addEventListener("turbolinks:load", () => {
  const hamburgerElement = document.querySelector(
    ".navbar-burger"
  ) as HTMLElement;
  new MenuHamburger(hamburgerElement).initHandlers();
});
