# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Communication Language

All conversations and interactions should be conducted in Japanese (日本語).

## Repository Overview

This repository manages design specifications for an AI-driven Scrum development organization. It aims to automate Scrum events through AI Agent dialogue using Claude Code's SubAgent functionality.

## Project Structure

```
├── README.md - Basic project information
├── CLAUDE.md - Guidance for Claude Code
├── roles/ - AI Agent role specifications
│   ├── ProductOwnerAgent.md - Product Owner Agent behavioral guidelines
│   ├── ScrumMasterAgent.md - Scrum Master Agent behavioral guidelines  
│   ├── DeveloperAgent.md - Developer Agent behavioral guidelines
│   ├── QualityAgent.md - Quality Agent behavioral guidelines
│   ├── DesignerAgent.md - Designer Agent behavioral guidelines
│   └── StakeholderAgent.md - Stakeholder Agent behavioral guidelines
└── scrumEvents/ - Scrum event specifications
    ├── SprintPlanning.md - Sprint Planning automation specifications
    ├── DailyScrum.md - Daily Scrum automation specifications
    ├── SprintReview.md - Sprint Review automation specifications
    ├── SprintRetrospective.md - Sprint Retrospective specifications
    └── SprintBacklogRefinement.md - Backlog Refinement specifications
```

## AI Agent System Architecture

### Core Concept
Uses Claude Code's Task tool to launch SubAgents and automate Scrum events through dialogue between role-specialized AI Agents.

### Agent Roles
- **ProductOwnerAgent**: Business value maximization and backlog management
- **ScrumMasterAgent**: Process coordination and inter-Agent facilitation
- **DeveloperAgent**: Technical implementation (Frontend/Backend/Infrastructure specialization)
- **QualityAgent**: Quality assurance and testing strategy
- **DesignerAgent**: UX/UI design and design system management
- **StakeholderAgent**: External requirements collection and coordination

### Automated Scrum Events
1. **SprintPlanning**: 4-phase collaborative planning process
2. **DailyScrum**: Daily automated progress synchronization
3. **SprintReview**: Automated demo and feedback collection
4. **SprintRetrospective**: KPT-format continuous improvement
5. **SprintBacklogRefinement**: Continuous backlog refinement

## Development Approach

### AI-First Development
This project focuses on AI Agent dialogue design and Scrum process automation rather than code development.

### Agent Interaction Patterns
- **Sequential Dialog**: Sequential dialogue between Agents
- **Parallel Analysis**: Parallel analysis followed by integration
- **Consensus Building**: Discussion and consensus formation

### Data Sharing Protocol
Defines data formats for context sharing and session coordination between Agents.

## Usage Guidelines

### For Role Specifications
Refer to the behavioral guidelines for each Agent in the `roles/` directory as guidance when using Claude Code in specific roles.

### For Event Automation
Follow the specifications in the `scrumEvents/` directory to implement automation for each Scrum event.

### Agent Activation Example
```
# To act as ProductOwnerAgent
Task(
    subagent_type="product-owner",
    description="Backlog analysis",
    prompt="Follow the behavioral guidelines in roles/ProductOwnerAgent.md to analyze top 5 priority items"
)
```