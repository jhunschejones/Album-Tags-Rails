import * as ActiveStorage from "@rails/activestorage";
import Rails from "@rails/ujs";
import * as Channels from "channels";
import Turbolinks from "turbolinks";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import MenuHamburger from "src/menu_hamburger";
import AlbumCardToggle from "src/album_card_toggle";

document.addEventListener("turbolinks:load", () => {
  new MenuHamburger(
    document.querySelector(".navbar-burger") as HTMLElement
  ).initHandlers();

  document.querySelectorAll("a[class*='toggle']").forEach((toggleElement) => {
    new AlbumCardToggle(toggleElement as HTMLElement).initHandlers();
  });
});
