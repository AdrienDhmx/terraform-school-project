## **Scénario**

L'Université Exemple se prépare à la nouvelle année scolaire. Le service des admissions a reçu des plaintes selon lesquelles son application web pour les dossiers des étudiants est lente ou n'est pas disponible pendant la période de pointe des admissions en raison du nombre élevé de demandes de renseignements.

Vous êtes un ingénieur cloud. Votre responsable vous a demandé de créer une preuve de concept (POC) pour héberger l'application web dans le Cloud AWS. Votre responsable souhaite que vous conceviez et mettiez en œuvre une nouvelle architecture d'hébergement qui améliorera l'expérience des utilisateurs de l'application web. Vous êtes chargé de mettre en place l'infrastructure permettant d'héberger l'application web des dossiers des étudiants dans le cloud.

Votre défi consiste à planifier, concevoir, construire et déployer l'application web sur le Cloud AWS d'une manière conforme aux bonnes pratiques du cadre AWS Well-Architected Framework. Lors des pics d'admission, l'application doit prendre en charge des milliers d'utilisateurs, pouvoir être mise à l'échelle et être hautement disponible, à charge équilibrée, sécurisée et performante.

## **Conditions requises par la solution**

La solution doit répondre aux exigences suivantes :

- **Fonctionnelle :** la solution répond aux exigences fonctionnelles, telles que la possibilité de consulter, d'ajouter, de supprimer ou de modifier les dossiers des étudiants, sans latence perceptible.
- **À charge équilibrée :** la solution peut équilibrer correctement le trafic des utilisateurs afin d'éviter la surcharge ou la sous-utilisation des ressources.
- **Pouvant être mise à l'échelle :** la solution est conçue pour être mise à l'échelle pour répondre aux exigences de l'application.
- **Hautement disponible :** la solution est conçue pour limiter les temps d'arrêt en cas d'indisponibilité d'un serveur web.
- **Sécurisée :**
    - La base de données est sécurisée et il est impossible d'y accéder directement à partir de réseaux publics.
    - Les serveurs web et la base de données ne sont accessibles que par les ports appropriés.
    - L'application web est accessible via Internet.
    - Les identifiants de la base de données ne sont pas codés en dur dans l'application web.
- **Coûts optimisés :** la solution est conçue pour maintenir les coûts à un niveau bas.
- **Très performante :** les opérations de routine (consultation, ajout, suppression ou modification d'enregistrements) sont effectuées sans latence perceptible dans des conditions de charge normale, variable et de pointe.

**Hypothèses**

Ce projet sera réalisé dans un environnement d'atelier contrôlé qui comporte des restrictions en matière de services, de fonctionnalités et de budget. Envisagez les hypothèses suivantes pour le projet :

- L'application est déployée dans une seule région AWS (il n'est pas nécessaire que la solution soit multirégionale).
- Il n'est pas nécessaire que le site web soit disponible via HTTPS ou un domaine personnalisé.
- La solution est déployée sur les machines *Ubuntu* en utilisant le code JavaScript fourni.
- Utilisez le code JavaScript tel qu'il est écrit, à moins que les instructions ne vous demandent expressément de modifier le code.
- La solution utilise des services et des fonctionnalités dans les limites de l'environnement de l'atelier.
- La base de données est hébergée dans une seule zone de disponibilité.
- Le site web est publiquement accessible sans authentification.
- L'estimation des coûts est approximative.

**Avertissement :** une bonne pratique de sécurité consiste à autoriser l'accès au site web via le réseau de l'université et l'authentification. Cependant, comme vous créez cette application en tant que POC, ces fonctionnalités sortent du cadre de ce projet. Nous vous encourageons à mettre en œuvre cette fonctionnalité supplémentaire.

## **Approche**

**Recommandation :** développez la solution de votre projet en plusieurs phases. Cela vous permettra de garantir que les fonctionnalités de base fonctionnent avant que l'architecture ne devienne plus complexe. Une fois que l'application fonctionne, vous êtes encouragé à améliorer la solution en y ajoutant des exigences supplémentaires.

### **Phase 1 : Création d'une application web fonctionnelle de base**

Au cours de cette phase, vous commencerez à élaborer la solution. L'objectif de cette phase est de disposer d'une application web fonctionnelle qui fonctionne sur une seule machine virtuelle dans un réseau virtuel que vous créez. À la fin de cette phase, vous disposerez d'un POC pour démontrer l'hébergement de l'application sur le Cloud AWS. Vous pourrez ensuite vous appuyer sur votre travail lors des phases ultérieures.

- Créez un réseau virtuel pour héberger l'application web.
- Pour installer l'application web et la base de données requises sur la machine virtuelle, utilisez le code JavaScript à partir du lien suivant : SolutionCodePOC
- Testez le déploiement de l'application web pour vous assurer qu'elle est accessible à partir d'Internet et qu'elle fonctionne. Effectuez quelques tâches, telles que l'affichage, l'ajout, la suppression ou la modification d'enregistrements.

### **Phase 2 : Découplage des composants de l'application**

Au cours de cette phase, vous continuerez à créer votre application. L'objectif consiste à séparer la base de données et l'infrastructure du serveur web de manière à ce qu'elles fonctionnent indépendamment l'une de l'autre. L'application web doit être exécutée sur une machine virtuelle distincte et la base de données doit être exécutée sur l'infrastructure de services gérés.

- Mettez à jour ou recréez les composants du réseau virtuel nécessaires à l'hébergement de la base de données séparément de l'application.
- Créez une base de données Amazon Relational Database Service (Amazon RDS) qui exécute un moteur MySQL. Vous pouvez choisir de créer une instance provisionnée ou de l'exécuter sans serveur.
- Mettez en service un environnement AWS Cloud9 pour exécuter les commandes de l'interface de ligne de commande AWS (AWS CLI) dans les tâches ultérieures.
- Utilisez AWS Secrets Manager pour créer un secret afin de stocker les informations d'identification de la base de données, et configurez l'application web pour qu'elle utilise Secrets Manager. Utilisez le *Script-1* du lien suivant pour créer un secret dans Secrets Manager à l'aide de l'interface AWS CLI : Scripts AWS Cloud9
- Créez une nouvelle machine virtuelle pour héberger l'application web. Pour installer l'application web requise sur la machine virtuelle, utilisez le code JavaScript à partir du lien suivant : Code de la solution pour le serveur d'application
- Migrez les données de la base de données d'origine, qui se trouve sur une instance EC2, vers la nouvelle base de données Amazon RDS. Utilisez le *Script-3* du fichier de scripts AWS Cloud9 (cloud9-scripts.yml) pour migrer les données d'origine dans la base de données Amazon RDS
- Accédez à l'application et effectuez quelques tâches pour la tester. Par exemple, vous pouvez consulter, ajouter, supprimer et modifier les dossiers des étudiants.

### **Phase 3 : Mise en œuvre de la haute disponibilité et de la capacité de mise à l'échelle élevée**

Au cours de cette phase, vous achèverez la conception et répondrez aux exigences restantes de la solution. L'objectif est d'utiliser les composants clés que vous avez créés dans les phases précédentes pour construire une architecture pouvant être mise à l'échelle et hautement disponible.

- Lancez un équilibreur de charge. Le point de terminaison sera utilisé pour accéder à votre application web.
- Créez un nouveau modèle de lancement et utilisez un groupe Auto Scaling pour lancer les instances EC2 qui hébergent l'application web.
- Accédez à l'application et effectuez quelques tâches pour la tester. Par exemple, vous pouvez consulter, ajouter, supprimer et modifier les dossiers des étudiants.
- Effectuez un test de charge sur l'application pour contrôler la mise à l'échelle. Utilisez le *Script-2* du fichier de scripts AWS Cloud9 (cloud9-scripts.yml) pour effectuer le test de charge. Rappelez-vous que vous avez utilisé des scripts de ce fichier dans les tâches précédentes. https://github.com/alexfernandez/loadtest

### **Phase 4 : Packaging de l'application**

L’objectif est de préparer l’application pour être facilement déployable.

- Créer un **Dockerfile** pour conteneuriser l’application.
- Stocker l’image sur **Amazon Elastic Container Registry (ECR)** ou une autre regitry
- Tester l’exécution du package localement et sur une instance EC2.

### **Phase 5 : Mise en place d’une pipeline CI/CD**

L’objectif est d’automatiser le déploiement.

- Configurer un **GitLab CI/CD**, **GitHub Actions** ou **AWS CodePipeline**.
- Définir les étapes :
    - Build de l’application.
    - Test de qualité
    - Packaging et push de l’image Docker.
    - Test de charge.
    - Déploiement sur l’environnement de production

## **Barème et consignes d'évaluation**

Chaque phase du projet est évaluée sur 6 **pilules**, répartis selon les critères suivants :

| Critère | Description | Points |
| --- | --- | --- |
| **Schéma d'architecture** | Réaliser un schéma clair et détaillé illustrant l'architecture mise en place pour la phase. | **1 étoile** |
| **Code Terraform** | Partager et structurer correctement le code Terraform utilisé pour automatiser le déploiement de l'infrastructure. | **4 étoiles** |
| **Document de synthèse** | Rédiger un rapport synthétique présentant les résultats obtenus, les choix techniques effectués et les éventuelles difficultés rencontrées. | **1 étoile** |
| **Total** | **5 points par phase** |  |

**Consignes générales :**

- **Schéma d'architecture** : Peut être réalisé avec **Draw.io, Excalidraw, AWS Architecture Diagram Tool** ou tout autre outil de modélisation.
- **Code Terraform** : Doit être bien structuré avec des modules si nécessaire et versionné sur un **repository Git**.
- **Document de synthèse** : Présenter l'évolution de l'application et de l'infrastructure en mettant en avant les améliorations et performances obtenues. (README)
