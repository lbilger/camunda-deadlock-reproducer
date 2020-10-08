--
-- Copyright © 2012 - 2018 camunda services GmbH and various authors (info@camunda.com)
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

CREATE TABLE ACT_ID_GROUP (
    ID_   NVARCHAR(64),
    REV_  INT,
    NAME_ NVARCHAR(255),
    TYPE_ NVARCHAR(255),
    PRIMARY KEY (ID_)
);

CREATE TABLE ACT_ID_MEMBERSHIP (
    USER_ID_  NVARCHAR(64),
    GROUP_ID_ NVARCHAR(64),
    PRIMARY KEY (USER_ID_, GROUP_ID_)
);

CREATE TABLE ACT_ID_USER (
    ID_            NVARCHAR(64),
    REV_           INT,
    FIRST_         NVARCHAR(255),
    LAST_          NVARCHAR(255),
    EMAIL_         NVARCHAR(255),
    PWD_           NVARCHAR(255),
    SALT_          NVARCHAR(255),
    LOCK_EXP_TIME_ DATETIME2,
    ATTEMPTS_      INT,
    PICTURE_ID_    NVARCHAR(64),
    PRIMARY KEY (ID_)
);

CREATE TABLE ACT_ID_INFO (
    ID_        NVARCHAR(64),
    REV_       INT,
    USER_ID_   NVARCHAR(64),
    TYPE_      NVARCHAR(64),
    KEY_       NVARCHAR(255),
    VALUE_     NVARCHAR(255),
    PASSWORD_  IMAGE,
    PARENT_ID_ NVARCHAR(255),
    PRIMARY KEY (ID_)
);

CREATE TABLE ACT_ID_TENANT (
    ID_   NVARCHAR(64),
    REV_  INT,
    NAME_ NVARCHAR(255),
    PRIMARY KEY (ID_)
);

CREATE TABLE ACT_ID_TENANT_MEMBER (
    ID_        NVARCHAR(64) NOT NULL,
    TENANT_ID_ NVARCHAR(64) NOT NULL,
    USER_ID_   NVARCHAR(64),
    GROUP_ID_  NVARCHAR(64),
    PRIMARY KEY (ID_)
);

ALTER TABLE ACT_ID_MEMBERSHIP
    ADD CONSTRAINT ACT_FK_MEMB_GROUP
        FOREIGN KEY (GROUP_ID_)
            REFERENCES ACT_ID_GROUP(ID_);

ALTER TABLE ACT_ID_MEMBERSHIP
    ADD CONSTRAINT ACT_FK_MEMB_USER
        FOREIGN KEY (USER_ID_)
            REFERENCES ACT_ID_USER(ID_);

ALTER TABLE ACT_ID_TENANT_MEMBER
    ADD CONSTRAINT ACT_FK_TENANT_MEMB
        FOREIGN KEY (TENANT_ID_)
            REFERENCES ACT_ID_TENANT(ID_);

ALTER TABLE ACT_ID_TENANT_MEMBER
    ADD CONSTRAINT ACT_FK_TENANT_MEMB_USER
        FOREIGN KEY (USER_ID_)
            REFERENCES ACT_ID_USER(ID_);

ALTER TABLE ACT_ID_TENANT_MEMBER
    ADD CONSTRAINT ACT_FK_TENANT_MEMB_GROUP
        FOREIGN KEY (GROUP_ID_)
            REFERENCES ACT_ID_GROUP(ID_);

CREATE UNIQUE INDEX ACT_UNIQ_TENANT_MEMB_USER ON ACT_ID_TENANT_MEMBER(TENANT_ID_, USER_ID_) WHERE USER_ID_ IS NOT NULL;
CREATE UNIQUE INDEX ACT_UNIQ_TENANT_MEMB_GROUP ON ACT_ID_TENANT_MEMBER(TENANT_ID_, GROUP_ID_) WHERE GROUP_ID_ IS NOT NULL;
