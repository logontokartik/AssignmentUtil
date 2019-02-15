# Assignment Rerun Process
Use for Lead and Case Assignments when assignments do not run by default

## Usage

Take a look at LeadAssignmentTrigger. Copy or clone the code for either Lead or Case objects.

### Using Custom Metadata Types
There is a Custom Metadata Type defined, Assignment Config with an example LeadRule. Use this to conditionally execute the 
logic to re-assign records. You can put in any complex where clause.

<a href="https://githubsfdeploy.herokuapp.com?owner=logontokartik&repo=AssignmentUtil">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

### Note
The whereClause field on Custom Metadata Type might be hidden, please change the page layout to choose the field onto the layout.
