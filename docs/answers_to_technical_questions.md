# Technical questions

> How long did you spend on the code challenge?

I currently work Monday-Thursday at Turing and help the kids with remote school on Fridays. After receving the challenge, I spent the first few days after work planning and mentally preparing myself. These days consisted of setting up the repo, writing user stories, and researching anything I was unfamiliar with.

The bulk of the work put in started Friday afternoon and all day Saturday and Sunday. Continued to work on the challenge after work on Monday and Tuesday. 

> What would you add to your solution if you had more time?

I definitely spent most of my time building the back end portion of this challnge. Back end engineering was my area of focus at Turing but I am very interested in learning front end technologies. If I had more time, I would have spent it fully building out the user interface as the current status of it at the time this was written is minimal. I did take a break from the back end to play around a bit building out a nav bar with bootsrap components. 

With the time that I had, I did want to make sure all the features integrated in the back end were working correctly and tested. Given more time, I would have liked to build another iteration of the logic behind unique stats and names on the roster, 

> What was the most useful feature that was added to the latest version of a language you used?
Please include a snippet of code that shows how you've used it

Most of the time spent was written in ruby, and I did use the latest version. I researched new features that have been added and while I did find some interesting and cool, I didn't find opportunites to include them into the challenge. I could have tried to force them in but that didn't feel right to me. 

I'm not sure if you can consider rails a 'language' but being new to rails 6, I did find some useful features such as:

```shell
db:prepare
```
vs 
```shell
rails db:{drop,create,migrate,seed}
```

and 

```ruby
Model.filter_attributes
```
```shell
[1] pry(main)> Team.first

=> #<Team:0x00007f9b70320448 id: 1, email: "average@joes.com", password_digest: "[FILTERED]", name: "Above Average  Joes", created_at: Wed, 28 Oct 2020 03:34:59 UTC +00:00, updated_at: Wed, 28 Oct 2020 03:49:37 UTC +00:00>
```

My time spent developing in React is also minimal but I did find being able to directly import bootstrap as React components super useful. 

```js
import React, { Component } from 'react'
import { 
  Container,
  NavItem,
  Navbar,
  Nav
} from 'react-bootstrap';

class AppNavbar extends Component {
  render() {
    return (
      <Navbar 
        collapseOnSelect 
        expand="lg"
        bg="dark"
        variant="dark"
        className="mb-5"
      >
        <Container>
          <Navbar.Brand href="/" >Robot Sports League</Navbar.Brand>
          <Navbar.Toggle aria-controls="responsive-navbar-nav" />
          <Navbar.Collapse id="responsive-navbar-nav">
            <Nav className="ml-auto">
              <NavItem>
                <Nav.Link href="#add-component-for-sign-in-modal">
                  Sign In
                </Nav.Link>
              </NavItem>
            </Nav>
          </Navbar.Collapse>
        </Container>
      </Navbar>
    );
  }
}

export default AppNavbar;
```

> How would you track down a performance issue in production? Have you ever had to do this?

My only experience with optimization has been through a small lesson in school. The application I'm currently working on at work is fairly new and we dont have too many records. Given a database with large amount of records, I would start first by looking at queries to see if they could be optimized. Another option for better response times would be caching.

> Please describe yourself using JSON

```json

{
  "data": {
    "id": "1",
    "type": "human",
    "attributes": {
      "name": "Sejin Kim",
      "attitude": "optimistic",
      "build": "athletic",
      "food_capacity": "large",
      "eating_speed": "Jimmy John's fast",
      "development_os": "Pop!_OS",
      "origin": "South Korea",
      "current_hobbies": [
        "building keyboards",
        "building computers",
        "competitive video games",
        "making the perfect cold brew",
      ],
      "pets": [
        {
          "name": "Lyra",
          "type": "cat"
        },
        {
          "name": "Icarus",
          "type": "cat"
        },
        {
          "name": "Zeus",
          "type": "cat"
        }
      ],
      "kids": [
        {
          "name": "Jamie",
          "age": "8"
        },
        {
          "name": "Jaren",
          "age": "5"
        }
      ],
      "other half": [
        {
          "name": "Maria"
        }
      ]
    }
  }
}
```