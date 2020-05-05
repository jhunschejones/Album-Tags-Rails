export default class AlbumCardToggle {
  element: HTMLElement;
  name: string;

  constructor(element: HTMLElement) {
    this.element = element;
    this.name = this.element.className.match(/\s?([a-z]+)-toggle\s?/)[1];
  }

  initHandlers(): void {
    this.element.addEventListener("click", this.onClick.bind(this));
    document.addEventListener("toggle-select", (e) => {
      (e as CustomEvent).detail.selected === this.name
        ? this.selectCard()
        : this.deselectCard();
    });
  }

  onClick(): void {
    document.dispatchEvent(
      new CustomEvent("toggle-select", { detail: { selected: this.name } })
    );
  }

  selectCard(): void {
    this.element.classList.add("is-active");
    document.querySelector(`.${this.name}-panel`).classList.add("is-active");
  }

  deselectCard(): void {
    this.element.classList.remove("is-active");
    document.querySelector(`.${this.name}-panel`).classList.remove("is-active");
  }
}
