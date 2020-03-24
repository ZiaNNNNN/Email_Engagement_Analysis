data = read.csv("/Users/zianzhang/Desktop/nyu/business_analytics/Project1/Email_engagement_1.csv", header = TRUE)

Email_Delivered <- subset(data, Action=="emailDelivered")
Frequency.1 <- as.data.frame(table(unlist(Email_Delivered$Element.Id)))
names(Frequency.1) <- c("ID","Emails_Delivered")

Email_Opened <- subset(data, Action=="emailOpened")
Frequency.2 <- as.data.frame(table(unlist(Email_Opened$Element.Id)))
names(Frequency.2) <- c("ID","Email_Opened")
Emails <- merge(x = Frequency.1, y = Frequency.2, by = 'ID', all = TRUE)

Page_view <- subset(data, Action=="pageview")
Frequency.3 <- as.data.frame(table(unlist(Page_view$Element.Id)))
names(Frequency.3) <- c("ID","Page_view")
Emails <- merge(x = Emails, y = Frequency.3, by = 'ID', all = TRUE)

User_created <- subset(data, Action=="userCreated")
Frequency.4 <- as.data.frame(table(unlist(User_created$Element.Id)))
names(Frequency.4) <- c("ID","User_created")
Emails <- merge(x = Emails, y = Frequency.4, by = 'ID', all = TRUE)

Link_Click <- subset(data, Action=="linkClick")
Frequency.5 <- as.data.frame(table(unlist(Link_Click$Element.Id)))
names(Frequency.5) <- c("ID","Link_Click")
Emails <- merge(x = Emails, y = Frequency.5, by = 'ID', all = TRUE)

Email_Clicked <- subset(data, Action=="emailClicked")
Frequency.6 <- as.data.frame(table(unlist(Email_Clicked$Element.Id)))
names(Frequency.6) <- c("ID","Email_Clicked")
Emails <- merge(x = Emails, y = Frequency.6, by = 'ID', all = TRUE)

Email_Unsubscribed <- subset(data, Action=="emailUnsubscribed")
Frequency.7 <- as.data.frame(table(unlist(Email_Unsubscribed$Element.Id)))
names(Frequency.7) <- c("ID","Email_Unsubscribed")
Emails <- merge(x = Emails, y = Frequency.7, by = 'ID', all = TRUE)

Form_Saved <- subset(data, Action=="formSaved")
Frequency.8 <- as.data.frame(table(unlist(Form_Saved$Element.Id)))
names(Frequency.8) <- c("ID","Form_Saved")
Emails <- merge(x = Emails, y = Frequency.8, by = 'ID', all = TRUE)

Email_Bounced <- subset(data, Action=="emailBounced")
Frequency.9 <- as.data.frame(table(unlist(Email_Bounced$Element.Id)))
names(Frequency.9) <- c("ID","Email_Bounced")
Emails <- merge(x = Emails, y = Frequency.9, by = 'ID', all = TRUE)

User_Prospect <- subset(data, Prospects=="1")
Frequency.pro <- as.data.frame(table(unlist(User_Prospect$Element.Id)))
names(Frequency.pro) <- c("ID","User_Prospect")

App_Started <- subset(data, Apps.Started=="1")
Frequency.as <- as.data.frame(table(unlist(App_Started$Element.Id)))
names(Frequency.as) <- c("ID","App_Started")
Users <- merge(x = Frequency.pro, y = Frequency.as, by = 'ID', all = TRUE)

App_Submited <- subset(data, Apps.Submit=="1")
Frequency.asub <- as.data.frame(table(unlist(App_Submited$Element.Id)))
names(Frequency.asub) <- c("ID","App_Submited")
Users <- merge(x = Users, y = Frequency.asub, by = 'ID', all = TRUE)

Admited <- subset(data, Admit=="1")
Frequency.ad <- as.data.frame(table(unlist(Admited$Element.Id)))
names(Frequency.ad) <- c("ID","Admited")
Users <- merge(x = Users, y = Frequency.ad, by = 'ID', all = TRUE)

Deposit <- subset(data, Deposit=="1")
Frequency.de <- as.data.frame(table(unlist(Deposit$Element.Id)))
names(Frequency.de) <- c("ID","Deposit")
Users <- merge(x = Users, y = Frequency.de, by = 'ID', all = TRUE)

Users$Status[Users$User_Prospect > 0 & Users$App_Started > 0 & Users$App_Submited > 0 & Users$Admited > 0 & Users$Deposit > 0] <- 'Deposit'
Users$Status[Users$User_Prospect > 0 & Users$App_Started > 0 & Users$App_Submited > 0 & Users$Admited > 0 & Users$Deposit == 0] <- 'Admit'
Users$Status[Users$User_Prospect > 0 & Users$App_Started > 0 & Users$App_Submited > 0 & Users$Admited == 0 & Users$Deposit == 0] <- 'App_Submit'
Users$Status[Users$User_Prospect > 0 & Users$App_Started > 0 & Users$App_Submited == 0 & Users$Admited == 0 & Users$Deposit == 0] <- 'App_Start'
Users$Status[Users$User_Prospect > 0 & Users$App_Started == 0 & Users$App_Submited == 0 & Users$Admited == 0 & Users$Deposit == 0] <- 'Prospect'
Users$Status[Users$User_Prospect == 0 & Users$App_Started == 0 & Users$App_Submited == 0 & Users$Admited == 0 & Users$Deposit == 0] <- 'Lead'
Users$Status[is.na(Users$Status)] <- 'Other'

Emails_final <- merge(x = Emails, y = Users, by = 'ID', all = TRUE)
write.csv(Emails_final, "/Users/zianzhang/Desktop/nyu/business_analytics/Project1/Emails_final.csv")
Emails_train <- Emails_final[, -c(11:15)]
write.csv(Emails_train, "/Users/zianzhang/Desktop/nyu/business_analytics/Project1/Emails_train.csv")
