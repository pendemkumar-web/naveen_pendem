 view: derived {
    derived_table: {
      explore_source: orders {
        column: count {}
        column: state { field: users.state }
        filters: {
          field: orders.status
          value: "COMPLETED"
        }
      }
    }
    dimension: count {
      description: ""
      type: number
    }
    dimension: state {
      description: ""
    }
  }
