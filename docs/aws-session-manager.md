# AWS Systems Manager Session Manager 
source: https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html

# Introduction
Session Manager is a fully managed AWS Systems Manager tool. With Session Manager, you can manage your Amazon Elastic Compute Cloud (Amazon EC2) instances, edge devices, on-premises servers, and virtual machines (VMs). You can use either an interactive one-click browser-based shell or the AWS Command Line Interface (AWS CLI). Session Manager provides secure node management without the need to open inbound ports, maintain bastion hosts, or manage SSH keys. Session Manager also allows you to comply with corporate policies that require controlled access to managed nodes, strict security practices, and logs with node access details, while providing end users with simple one-click cross-platform access to your managed nodes. To get started with Session Manager, open the Systems Manager console. In the navigation pane, choose Session Manager.


# How can Session Manager benefit my organization?
Session Manager offers these benefits:

## Centralized access control to managed nodes using IAM policies
Administrators have a single place to grant and revoke access to managed nodes. Using only AWS Identity and Access Management (IAM) policies, you can control which individual users or groups in your organization can use Session Manager and which managed nodes they can access.

## No open inbound ports and no need to manage bastion hosts or SSH keys
Leaving inbound SSH ports and remote PowerShell ports open on your managed nodes greatly increases the risk of entities running unauthorized or malicious commands on the managed nodes. Session Manager helps you improve your security posture by letting you close these inbound ports, freeing you from managing SSH keys and certificates, bastion hosts, and jump boxes.

## One-click access to managed nodes from the console and CLI
Using the AWS Systems Manager console or Amazon EC2 console, you can start a session with a single click. Using the AWS CLI, you can also start a session that runs a single command or a sequence of commands. Because permissions to managed nodes are provided through IAM policies instead of SSH keys or other mechanisms, the connection time is greatly reduced.

## Connect to both Amazon EC2 instances and non-EC2 managed nodes in hybrid and multicloud environments
You can connect to both Amazon Elastic Compute Cloud (Amazon EC2) instances and non-EC2 nodes in your hybrid and multicloud environment.

To connect to non-EC2 nodes using Session Manager, you must first activate the advanced-instances tier. There is a charge to use the advanced-instances tier. However, there is no additional charge to connect to EC2 instances using Session Manager. For information, see Configuring instance tiers.

## Port forwarding
Redirect any port inside your managed node to a local port on a client. After that, connect to the local port and access the server application that is running inside the node.

## Cross-platform support for Windows, Linux, and macOS
Session Manager provides support for Windows, Linux, and macOS from a single tool. For example, you don't need to use an SSH client for Linux and macOS managed nodes or an RDP connection for Windows Server managed nodes.

## Logging session activity
To meet operational or security requirements in your organization, you might need to provide a record of the connections made to your managed nodes and the commands that were run on them. You can also receive notifications when a user in your organization starts or ends session activity.

Logging capabilities are provided through integration with the following AWS services:
- AWS CloudTrail – AWS CloudTrail captures information about Session Manager API calls made in your AWS account and writes it to log files that are stored in an Amazon Simple Storage Service (Amazon S3) bucket you specify. One bucket is used for all CloudTrail logs for your account. For more information, see Logging AWS Systems Manager API calls with AWS CloudTrail.

- Amazon Simple Storage Service – You can choose to store session log data in an Amazon S3 bucket of your choice for debugging and troubleshooting purposes. Log data can be sent to your Amazon S3 bucket with or without encryption using your AWS KMS key. For more information, see Logging session data using Amazon S3 (console).

- Amazon CloudWatch Logs – CloudWatch Logs allows you to monitor, store, and access log files from various AWS services. You can send session log data to a CloudWatch Logs log group for debugging and troubleshooting purposes. Log data can be sent to your log group with or without AWS KMS encryption using your KMS key. For more information, see Logging session data using Amazon CloudWatch Logs (console).

- Amazon EventBridge and Amazon Simple Notification Service – EventBridge allows you to set up rules to detect when changes happen to AWS resources that you specify. You can create a rule to detect when a user in your organization starts or stops a session, and then receive a notification through Amazon SNS (for example, a text or email message) about the event. You can also configure a CloudWatch event to initiate other responses. For more information, see Monitoring session activity using Amazon EventBridge (console).

> Note Logging isn't available for Session Manager sessions that connect through port forwarding or SSH. This is because SSH encrypts all session data, and Session Manager only serves as a tunnel for SSH connections.

# Who should use Session Manager?
- Any AWS customer who wants to improve their security posture, reduce operational overhead by centralizing access control on managed nodes, and reduce inbound node access.
- Information Security experts who want to monitor and track managed node access and activity, close down inbound ports on managed nodes, or allow connections to managed nodes that don't have a public IP address.
- Administrators who want to grant and revoke access from a single location, and who want to provide one solution to users for Linux, macOS, and Windows Server managed nodes.
- Users who want to connect to a managed node with just one click from the browser or AWS CLI without having to provide SSH keys.

# What are the main features of Session Manager?

## Support for Windows Server, Linux and macOS managed nodes
Session Manager enables you to establish secure connections to your Amazon Elastic Compute Cloud (EC2) instances, edge devices, on-premises servers, and virtual machines (VMs). For a list of supported operating system types, see Setting up Session Manager.

> Note: Session Manager support for on-premises machines is provided for the advanced-instances tier only. For information, see Turning on the advanced-instances tier.

## Console, CLI, and SDK access to Session Manager capabilities
You can work with Session Manager in the following ways:

- The AWS Systems Manager console includes access to all the Session Manager capabilities for both administrators and end users. You can perform any task that is related to your sessions by using the Systems Manager console.
- The Amazon EC2 console provides the ability for end users to connect to EC2 instances for which they have been granted session permissions.
- The AWS CLI includes access to Session Manager capabilities for end users. You can start a session, view a list of sessions, and permanently end a session by using the AWS CLI.

> Note: To use the AWS CLI to run session commands, you must be using version 1.16.12 of the CLI (or later), and you must have installed the Session Manager plugin on your local machine. For information, see Install the Session Manager plugin for the AWS CLI. To view the plugin on GitHub, see session-manager-plugin.

## IAM access control
Through the use of IAM policies, you can control which members of your organization can initiate sessions to managed nodes and which nodes they can access. You can also provide temporary access to your managed nodes. For example, you might want to give an on-call engineer (or a group of on-call engineers) access to production servers only for the duration of their rotation.

## Logging support
Session Manager provide you with options for logging session histories in your AWS account through integration with a number of other AWS services. For more information, see Logging session activity and Enabling and disabling session logging.

## Configurable shell profiles
Session Manager provides you with options to configure preferences within sessions. These customizable profiles allow you to define preferences such as shell preferences, environment variables, working directories, and running multiple commands when a session is started.

## Customer key data encryption support
You can configure Session Manager to encrypt the session data logs that you send to an Amazon Simple Storage Service (Amazon S3) bucket or stream to a CloudWatch Logs log group. You can also configure Session Manager to further encrypt the data transmitted between client machines and your managed nodes during your sessions. For information, see Enabling and disabling session logging and Configure session preferences.

## AWS PrivateLink support for managed nodes without public IP addresses
You can also set up VPC Endpoints for Systems Manager using AWS PrivateLink to further secure your sessions. AWS PrivateLink limits all network traffic between your managed nodes, Systems Manager, and Amazon EC2 to the Amazon network. For more information, see Improve the security of EC2 instances by using VPC endpoints for Systems Manager.

## Tunneling
In a session, use a Session-type AWS Systems Manager (SSM) document to tunnel traffic, such as http or a custom protocol, between a local port on a client machine and a remote port on a managed node.

## Interactive commands
Create a Session-type SSM document that uses a session to interactively run a single command, giving you a way to manage what users can do on a managed node.

## What is a session?
A session is a connection made to a managed node using Session Manager. Sessions are based on a secure bi-directional communication channel between the client (you) and the remote managed node that streams inputs and outputs for commands. Traffic between a client and a managed node is encrypted using TLS 1.2, and requests to create the connection are signed using Sigv4. This two-way communication allows interactive bash and PowerShell access to managed nodes. You can also use an AWS Key Management Service (AWS KMS) key to further encrypt data beyond the default TLS encryption.

For example, say that John is an on-call engineer in your IT department. He receives notification of an issue that requires him to remotely connect to a managed node, such as a failure that requires troubleshooting or a directive to change a simple configuration option on a node. Using the AWS Systems Manager console, the Amazon EC2 console, or the AWS CLI, John starts a session connecting him to the managed node, runs commands on the node needed to complete the task, and then ends the session.

When John sends that first command to start the session, the Session Manager service authenticates his ID, verifies the permissions granted to him by an IAM policy, checks configuration settings (such as verifying allowed limits for the sessions), and sends a message to SSM Agent to open the two-way connection. After the connection is established and John types the next command, the command output from SSM Agent is uploaded to this communication channel and sent back to his local machine.

# Prereqs

## SSM Agent
At minimum, AWS Systems Manager SSM Agent version 2.3.68.0 or later must be installed on the managed nodes you want to connect to through sessions.

To use the option to encrypt session data using a key created in AWS Key Management Service (AWS KMS), version 2.3.539.0 or later of SSM Agent must be installed on the managed node.

To use shell profiles in a session, SSM Agent version 3.0.161.0 or later must be installed on the managed node.

To start a Session Manager port forwarding or SSH session, SSM Agent version 3.0.222.0 or later must be installed on the managed node.

To stream session data using Amazon CloudWatch Logs, SSM Agent version 3.0.284.0 or later must be installed on the managed node.

For information about how to determine the version number running on an instance, see Checking the SSM Agent version number. For information about manually installing or automatically updating SSM Agent, see Working with SSM Agent.

### About the ssm-user account
Starting with version 2.3.50.0 of SSM Agent, the agent creates a user account on the managed node, with root or administrator permissions, called ssm-user. (On versions before 2.3.612.0, the account is created when SSM Agent starts or restarts. On version 2.3.612.0 and later, ssm-user is created the first time a session starts on the managed node.) Sessions are launched using the administrative credentials of this user account. For information about restricting administrative control for this account, see Turn off or turn on ssm-user account administrative permissions.

# Install Session Manager Plugin
see: 
- https://docs.aws.amazon.com/systems-manager/latest/userguide/install-plugin-macos-overview.html
- https://github.com/aws/session-manager-plugin

```bash
$ session-manager-plugin
The Session Manager plugin was installed successfully. Use the AWS CLI to start a session.
```

To start a session, have an instance-id of an ec2 instance to connect:

```bash
$ aws ssm start-session --target instance-id
```

## SSH over SSM

```bash
ssh -o ProxyCommand="aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'" ec2-user@i-0f1dab9d426f55a54
```
