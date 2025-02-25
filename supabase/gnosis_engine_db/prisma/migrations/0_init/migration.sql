-- CreateTable
CREATE TABLE "t_events_100" (
    "contract" TEXT NOT NULL,
    "event_signature" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_logs_100" (
    "hash" TEXT NOT NULL,
    "tx_hash" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "nonce" INTEGER NOT NULL,
    "sender" TEXT NOT NULL,
    "dest" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "data" JSONB,
    "extra_data" JSONB,
    "status" TEXT NOT NULL DEFAULT 'success',

    CONSTRAINT "t_logs_100_pkey" PRIMARY KEY ("hash")
);

-- CreateTable
CREATE TABLE "t_logs_data_100" (
    "hash" TEXT NOT NULL,
    "data" JSONB,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "t_logs_data_100_pkey" PRIMARY KEY ("hash")
);

-- CreateTable
CREATE TABLE "t_push_token_100_0x0fbe2cebf8c2833b6735022d022abe1d3c6c74a1" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_100_0x27f69bcdb85e6ed437ff3efc114d7125b7338bfa" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_100_0x420ca0f9b9b604ce0fd9c18ef134c705e5fa3430" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_100_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_100_0x6b3a1f4277391526413f583c23d5b9ef4d2fe986" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_100_0xa555d5344f6fb6c65da19e403cb4c1ec4a1a5ee3" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_100_0xce2e989b16f2463b8263d14ded66c7246e632758" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_100_0xf941c675f9bf62dc1e1406bd5e4b237b4bee8deb" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_sponsors_100" (
    "contract" TEXT NOT NULL,
    "pk" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "t_sponsors_100_pkey" PRIMARY KEY ("contract")
);

-- CreateIndex
CREATE INDEX "idx_events_100_contract" ON "t_events_100"("contract");

-- CreateIndex
CREATE INDEX "idx_events_100_contract_signature" ON "t_events_100"("contract", "event_signature");

-- CreateIndex
CREATE UNIQUE INDEX "t_events_100_contract_event_signature_key" ON "t_events_100"("contract", "event_signature");

-- CreateIndex
CREATE INDEX "idx_logs_100_dest" ON "t_logs_100"("dest");

-- CreateIndex
CREATE INDEX "idx_logs_100_dest_date" ON "t_logs_100"("dest", "created_at");

-- CreateIndex
CREATE INDEX "idx_logs_100_tx_hash" ON "t_logs_100"("tx_hash");

-- CreateIndex
CREATE INDEX "idx_logs_data_100_hash" ON "t_logs_data_100"("hash");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__6c74a1_account" ON "t_push_token_100_0x0fbe2cebf8c2833b6735022d022abe1d3c6c74a1"("account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__6c74a1_token_account" ON "t_push_token_100_0x0fbe2cebf8c2833b6735022d022abe1d3c6c74a1"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_100_0x0fbe2cebf8c2833b6735022d02_token_account_key" ON "t_push_token_100_0x0fbe2cebf8c2833b6735022d022abe1d3c6c74a1"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__338bfa_account" ON "t_push_token_100_0x27f69bcdb85e6ed437ff3efc114d7125b7338bfa"("account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__338bfa_token_account" ON "t_push_token_100_0x27f69bcdb85e6ed437ff3efc114d7125b7338bfa"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_100_0x27f69bcdb85e6ed437ff3efc11_token_account_key" ON "t_push_token_100_0x27f69bcdb85e6ed437ff3efc114d7125b7338bfa"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__fa3430_account" ON "t_push_token_100_0x420ca0f9b9b604ce0fd9c18ef134c705e5fa3430"("account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__fa3430_token_account" ON "t_push_token_100_0x420ca0f9b9b604ce0fd9c18ef134c705e5fa3430"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_100_0x420ca0f9b9b604ce0fd9c18ef1_token_account_key" ON "t_push_token_100_0x420ca0f9b9b604ce0fd9c18ef134c705e5fa3430"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__f7a7f1_account" ON "t_push_token_100_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1"("account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__f7a7f1_token_account" ON "t_push_token_100_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_100_0x5815e61ef72c9e6107b5c5a05f_token_account_key" ON "t_push_token_100_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__2fe986_account" ON "t_push_token_100_0x6b3a1f4277391526413f583c23d5b9ef4d2fe986"("account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__2fe986_token_account" ON "t_push_token_100_0x6b3a1f4277391526413f583c23d5b9ef4d2fe986"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_100_0x6b3a1f4277391526413f583c23_token_account_key" ON "t_push_token_100_0x6b3a1f4277391526413f583c23d5b9ef4d2fe986"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__1a5ee3_account" ON "t_push_token_100_0xa555d5344f6fb6c65da19e403cb4c1ec4a1a5ee3"("account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__1a5ee3_token_account" ON "t_push_token_100_0xa555d5344f6fb6c65da19e403cb4c1ec4a1a5ee3"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_100_0xa555d5344f6fb6c65da19e403c_token_account_key" ON "t_push_token_100_0xa555d5344f6fb6c65da19e403cb4c1ec4a1a5ee3"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__632758_account" ON "t_push_token_100_0xce2e989b16f2463b8263d14ded66c7246e632758"("account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__632758_token_account" ON "t_push_token_100_0xce2e989b16f2463b8263d14ded66c7246e632758"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_100_0xce2e989b16f2463b8263d14ded_token_account_key" ON "t_push_token_100_0xce2e989b16f2463b8263d14ded66c7246e632758"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__ee8deb_account" ON "t_push_token_100_0xf941c675f9bf62dc1e1406bd5e4b237b4bee8deb"("account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__ee8deb_token_account" ON "t_push_token_100_0xf941c675f9bf62dc1e1406bd5e4b237b4bee8deb"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_100_0xf941c675f9bf62dc1e1406bd5e_token_account_key" ON "t_push_token_100_0xf941c675f9bf62dc1e1406bd5e4b237b4bee8deb"("token", "account");

