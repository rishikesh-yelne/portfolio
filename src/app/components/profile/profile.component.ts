import { Component, OnInit } from '@angular/core';

@Component({
	selector: 'app-profile',
	templateUrl: './profile.component.html',
	styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {

	constructor() { }

	ngOnInit(): void {
	}

	open(link: string) {
		switch (link) {
			case "linkedin":
				window.open("https://www.linkedin.com/in/rishikesh-yelne/", "_blank");
				break;
			case "github":
				window.open("https://github.com/rishikesh-yelne", "_blank");
				break;
			case "resume":
				window.open("https://drive.google.com/file/d/1ktvtgZLsOGyhjcOuGg3Z7ACdRW-5Klgq/view?usp=sharing", "_blank");
				break;
		}
	}
}
