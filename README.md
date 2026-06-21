# Enterprise DevSecOps CI/CD Pipeline

[![Tfsec Security Scan](https://img.shields.io/badge/Security-Tfsec%20Passed-brightgreen?style=for-the-badge&logo=aquasecurity)](https://github.com/hazzikri/devsecops-enterprise-project/actions)
[![IaC Provisioning](https://img.shields.io/badge/IaC-Terraform-7B42BC?style=for-the-badge&logo=terraform)](https://github.com/hazzikri/devsecops-enterprise-project)
[![Configuration Hardening](https://img.shields.io/badge/Ansible-Hardened-red?style=for-the-badge&logo=ansible)](https://github.com/hazzikri/devsecops-enterprise-project)
[![Kubernetes KinD](https://img.shields.io/badge/Orchestration-Kubernetes%20KinD-326CE5?style=for-the-badge&logo=kubernetes)](https://github.com/hazzikri/devsecops-enterprise-project)

An enterprise-grade DevSecOps pipeline demonstrating automated infrastructure provisioning, multi-stage CI/CD security guardrails, configuration management, and cloud-native application orchestration.

---

## 🚀 Architecture Overview

This project establishes a complete shift-left security implementation and automated deployment lifecycle:

```mermaid
graph TD
    A[Code Push / PR] -->|Trigger| B(GitHub Actions Pipeline)
    
    subgraph IaC Scan
        B --> C[Tfsec Scan]
        C -->|Check Terraform Misconfigs| D{Security Passed?}
        D -->|No| E[Fail Build & Alert]
        D -->|Yes| F[Proceed]
    end

    subgraph Config Management
        F --> G[Ansible Playbook Run]
        G --> H[Apply OS & App Hardening]
    end

    subgraph Kubernetes Deployment
        H --> I[Spin up Ephemeral KinD Cluster]
        I --> J[Deploy App via Helm Chart]
        J --> K[Verify Pod Status & Services]
    end
```

1. **Infrastructure as Code (IaC):** Architecture defined locally using Terraform.
2. **Shift-Left Security Scanning:** Automated static analysis using `tfsec` within the CI pipeline to detect infrastructure misconfigurations before deployment.
3. **Configuration Management:** Ansible Playbook integration for automated server hardening and secure audit logging.
4. **Cloud-Native Deployment:** Automated application packaging using Helm and orchestration through Kubernetes, validated on ephemeral KinD clusters.

---

## 🛠️ Technology Stack

* **CI/CD Platform:** GitHub Actions (Multi-Stage Pipelines)
* **Infrastructure Provisioning:** Terraform
* **Security & Compliance:** Aqua Security tfsec
* **Configuration Management:** Ansible
* **Package Management:** Helm v3
* **Container Orchestration:** Kubernetes (KinD & Docker Desktop)
* **Monitoring & Observability:** Gatus & Grafana Enterprise

---

## ⚙️ CI/CD Pipeline Stages

The GitHub Actions workflow (`devsecops.yaml`) automatically runs the following jobs on every push to the `main` branch or pull request:

### 1. IaC Security Scan (`terraform-security`)
* Checks out the Terraform codebase.
* Runs Aqua Security's `tfsec` static analysis.
* Detects insecure configurations (e.g., open security groups, unencrypted resources) and fails the build if security policies are violated.

### 2. Configuration Hardening (`ansible-configuration`)
* Runs an Ansible playbook to hardened servers.
* Automatically provisions a secure audit directory and logs security validation details.

### 3. KinD Cluster Deployment (`helm-kind-deploy`)
* Creates an ephemeral **Kubernetes in Docker (KinD)** cluster inside the GitHub runner.
* Provisions Gatus and Grafana Enterprise services using custom Helm charts.
* Verifies deployment by monitoring Kubernetes pods and cluster services.

---

## 📁 Repository Structure

```
devsecops-enterprise-project/
├── .github/workflows/
│   └── devsecops.yaml          # Multi-stage GitHub Actions CI/CD
├── ansible/
│   └── playbook.yml            # Hardening & audit configuration
├── monitoring-app/
│   ├── templates/              # Kubernetes resource templates (Gatus/Grafana)
│   ├── Chart.yaml              # Helm Chart details
│   └── values.yaml             # Helm value overrides
├── main.tf                     # Local container deployment via Terraform
└── README.md                   # Project documentation
```

---

## 🧪 Local Testing Instructions

### Prerequisites
* Terraform
* Ansible
* Docker & KinD
* Helm v3

### Running Terraform Locally
```bash
terraform init
terraform plan
terraform apply
```

### Running Ansible Hardening Locally
```bash
ansible-playbook ansible/playbook.yml
```

### Running Helm Deployment Locally
```bash
# Create kind cluster
kind create cluster --name devsecops-cluster

# Deploy helm chart
helm install devsecops ./monitoring-app --values ./monitoring-app/values.yaml

# Verify deployment
kubectl get pods -A
```
