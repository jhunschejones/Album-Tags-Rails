import * as ActiveStorage from "@rails/activestorage";
import Rails from "@rails/ujs";
import * as Channels from "channels";
import Turbolinks from "turbolinks";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import MenuHamburger from "src/menu_hamburger";

document.addEventListener("turbolinks:load", () => {
  new MenuHamburger(document.querySelector(
    ".navbar-burger"
  ) as HTMLElement).initHandlers();
});
