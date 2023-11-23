# AWS App Runner with Terraform

## Lesson

https://digitalcloud.training/courses/aws-certified-solutions-architect-associate-hands-on-labs/sections/section-11-serverless-applications-1hr-30m/lessons/aws-lambda/

This creates:

- a lambda named `troll_chase_handler`
- a state machine named `trg15-sfn-state-machine`

To run the state machine go to `Step Functions > State Machines > trg15-sfn-state-machine`

To enter the cave, use the Input `{ "enterCave": true }`
To turn back, use the Input `{ "enterCave": false }`

The player meets the troll and runs. In parallel, the troll will either chase or not.

## Build

From the command line, run `npm run build13`

This will wrap the python into a zip, then deploy the zip to a lambda named `trg13-hello`

# Deliverable

Execution of the statemachine will result in the player meeting a troll. If the Troll catches the player, it will eat the player
