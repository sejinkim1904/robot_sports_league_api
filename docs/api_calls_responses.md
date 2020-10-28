# Endpoints

## Test account
```
email: stack_sports@rsl.com
password: password
```

**Table of Contents**
- [Create team](#create-team)
- [Login](#login) - You will need the token from this response for all other requests
- [Auto-login](#auto-login)
- [Edit team name](#edit-team-name)
- [Generate bots](#generate-bots)
- [Get all bots](#get-all-bots)
- [Generate roster](#generate-roster) - 10 Starters and 5 alternates
- [Get entire roster](#get-entire-roster) - Starters, alternates, and benchwarmers
- [Get current roster](#get-current-roster) - Starters and alternates
- [Update bot role on roster](#update-bot-role-on-roster)
- [Delete roster](#delete-roster)

## Create team

Request:
```
POST /api/v1/teams
```

Params:
```json
{
  name: Average Joes,
  email: average@joes.com
  password: password,
  password_confirmation: password
}
```

Example response:
```json
{
    "data": {
        "id": "1",
        "type": "team",
        "attributes": {
            "email": "average@joes.com",
            "name": "Average Joes"
        }
    }
}
```

## Login

Request:
```
POST /api/v1/login
```

Params:
```json
{
  email: average@joes.com,
  password: password
}
```

Example response:
```json
{
    "token": "tHiSiSaNeXaMpLeToKeN"
}
```
> You will need the token from this response for all other requests

## Auto-login

Request:
```
GET /api/v1/auto_login
```

Headers:
```
Authorization: Bearer tHiSiSaNeXaMpLeToKeN
```

Example response:
```json
{
    "data": {
        "id": "1",
        "type": "team",
        "attributes": {
            "email": "average@joes.com",
            "name": "Average Joes"
        }
    }
}
```

## Edit team name

Request:
```
PATCH /api/v1/teams/:id
```

Headers:
```
Authorization: Bearer tHiSiSaNeXaMpLeToKeN
```

Params:
```json
{
  name: Above Average Joes
}
```

Example response:
```json
{
    "data": {
        "id": "1",
        "type": "team",
        "attributes": {
            "email": "average@joes.com",
            "name": "Above Average  Joes"
        }
    }
}
```

## Generate bots

Request:
```
POST /api/v1/teams/generate_bots
```

Headers:
```
Authorization: Bearer tHiSiSaNeXaMpLeToKeN
```

Example response:
```json
{
    "data": [
        {
            "id": "1",
            "type": "bot",
            "attributes": {
                "name": "Ashly Dach",
                "speed": 23,
                "strength": 1,
                "agility": 8
            }
        },
        {
            "id": "2",
            "type": "bot",
            "attributes": {
                "name": "Hassan Hettinger",
                "speed": 17,
                "strength": 32,
                "agility": 14
            }
        },
        {...}
    [
}
```

## Get all bots

Request:
```
GET /api/v1/teams/bots
```

Headers:
```
Authorization: Bearer tHiSiSaNeXaMpLeToKeN
```

Example response:
```json
{
    "data": [
        {
            "id": "1",
            "type": "bot",
            "attributes": {
                "name": "Ashly Dach",
                "speed": 23,
                "strength": 1,
                "agility": 8
            }
        },
        {
            "id": "2",
            "type": "bot",
            "attributes": {
                "name": "Hassan Hettinger",
                "speed": 17,
                "strength": 32,
                "agility": 14
            }
        },
        {...}
    [
}
```

## Generate roster

Request:
```
POST /api/v1/teams/generate_roster
```

Headers:
```
Authorization: Bearer tHiSiSaNeXaMpLeToKeN
```

Example response:
```json
{
    "data": [
        {
            "id": "93",
            "type": "roster",
            "attributes": {
                "team": "Above Average  Joes",
                "role": "starter",
                "total_stats": 64,
                "bot": {
                    "id": 93,
                    "name": "Enoch Gerhold",
                    "speed": 50,
                    "strength": 3,
                    "agility": 11,
                    "created_at": "2020-10-28T03:55:56.823Z",
                    "updated_at": "2020-10-28T03:55:56.823Z"
                }
            }
        },
        {
            "id": "29",
            "type": "roster",
            "attributes": {
                "team": "Above Average  Joes",
                "role": "starter",
                "total_stats": 52,
                "bot": {
                    "id": 29,
                    "name": "Jordon Kuhn",
                    "speed": 13,
                    "strength": 3,
                    "agility": 36,
                    "created_at": "2020-10-28T03:55:56.418Z",
                    "updated_at": "2020-10-28T03:55:56.418Z"
                }
            }
        },
        {...}
    [
}
```
> Subsequest requests will generate a new roster.

## Get entire roster

Request:
```
GET /api/v1/teams/roster
```

Headers:
```
Authorization: Bearer tHiSiSaNeXaMpLeToKeN
```

Example response:
```json
{
    "data": [
        {
            "id": "1",
            "type": "roster",
            "attributes": {
                "team": "Above Average  Joes",
                "role": "benchwarmer",
                "total_stats": 32,
                "bot": {
                    "id": 1,
                    "name": "Ashly Dach",
                    "speed": 23,
                    "strength": 1,
                    "agility": 8,
                    "created_at": "2020-10-28T03:55:56.229Z",
                    "updated_at": "2020-10-28T03:55:56.229Z"
                }
            }
        },
        {
            "id": "2",
            "type": "roster",
            "attributes": {
                "team": "Above Average  Joes",
                "role": "benchwarmer",
                "total_stats": 63,
                "bot": {
                    "id": 2,
                    "name": "Hassan Hettinger",
                    "speed": 17,
                    "strength": 32,
                    "agility": 14,
                    "created_at": "2020-10-28T03:55:56.236Z",
                    "updated_at": "2020-10-28T03:55:56.236Z"
                }
            }
        },
        {...}
    [
}
```
> Response includes starters, alternates, and benchwarmers.

## Get current roster

Request:
```
GET /api/v1/teams/current_roster
```

Headers:
```
Authorization: Bearer tHiSiSaNeXaMpLeToKeN
```

Example response:
```json
{
    "data": [
        {
            "id": "93",
            "type": "roster",
            "attributes": {
                "team": "Above Average  Joes",
                "role": "starter",
                "total_stats": 64,
                "bot": {
                    "id": 93,
                    "name": "Enoch Gerhold",
                    "speed": 50,
                    "strength": 3,
                    "agility": 11,
                    "created_at": "2020-10-28T03:55:56.823Z",
                    "updated_at": "2020-10-28T03:55:56.823Z"
                }
            }
        },
        {
            "id": "29",
            "type": "roster",
            "attributes": {
                "team": "Above Average  Joes",
                "role": "starter",
                "total_stats": 52,
                "bot": {
                    "id": 29,
                    "name": "Jordon Kuhn",
                    "speed": 13,
                    "strength": 3,
                    "agility": 36,
                    "created_at": "2020-10-28T03:55:56.418Z",
                    "updated_at": "2020-10-28T03:55:56.418Z"
                }
            }
        },
        {...}
    [
}
```
> Response includes starters and alternates.

## Update bot role on roster

Request:
```
PATCH /api/v1/teams/current_roster/:id
```

Headers:
```
Authorization: Bearer tHiSiSaNeXaMpLeToKeN
```

Params:
```json
{
  role: benchwarmer
}
```

Example response:
```json
{
    "data": {
        "id": "93",
        "type": "roster",
        "attributes": {
            "team": "Above Average  Joes",
            "role": "benchwarmer",
            "total_stats": 64,
            "bot": {
                "id": 93,
                "name": "Enoch Gerhold",
                "speed": 50,
                "strength": 3,
                "agility": 11,
                "created_at": "2020-10-28T03:55:56.823Z",
                "updated_at": "2020-10-28T03:55:56.823Z"
            }
        }
    }
}
```

## Delete roster

Request:
```
DELETE /api/v1/teams/roster
```

Headers:
```
Authorization: Bearer tHiSiSaNeXaMpLeToKeN
```

Example response:
```json
{
    "message": "Roster has been deleted."
}
```