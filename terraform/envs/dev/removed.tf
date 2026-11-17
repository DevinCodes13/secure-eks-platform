removed {
  from = aws_budgets_budget.eks_dev
  lifecycle {
    destroy = false
  }
}
