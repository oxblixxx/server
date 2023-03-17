#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_iam_role" "socks-shop-worker-nodes" {
  name = "socks-shop-worker-node-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "socks-shop-worker-nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.socks-shop-worker-nodes.name
}

resource "aws_iam_role_policy_attachment" "socks-shop-worker-nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.socks-shop-worker-nodes.name
}

resource "aws_iam_role_policy_attachment" "socks-shop-worker-nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.socks-shop-worker-nodes.name
}

resource "aws_eks_node_group" "socks-shop" {
  cluster_name    = "socks-shop"
  node_group_name = "socks-shop"
  node_role_arn   = aws_iam_role.socks-shop-worker-nodes.arn
  subnet_ids      = module.socks-cluster-vpc.private_subnets
  instance_types  = ["t2.xlarge"]
  #  user_data       = file("server-script.sh")
  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 3
  }

  depends_on = [
    aws_iam_role_policy_attachment.socks-shop-worker-nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.socks-shop-worker-nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.socks-shop-worker-nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}
