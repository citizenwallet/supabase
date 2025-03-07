-- CreateTable
CREATE TABLE "t_events_100" (
    "contract" TEXT NOT NULL,
    "event_signature" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_events_42220" (
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
CREATE TABLE "t_logs_42220" (
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

    CONSTRAINT "t_logs_42220_pkey" PRIMARY KEY ("hash")
);

-- CreateTable
CREATE TABLE "t_logs_data_42220" (
    "hash" TEXT NOT NULL,
    "data" JSONB,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "t_logs_data_42220_pkey" PRIMARY KEY ("hash")
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
CREATE TABLE "t_push_token_100_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1" (
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
CREATE TABLE "t_push_token_42220_0x56744910f7decd48c1a7fa61b4c317b15e99f156" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_42220_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_42220_0x5f6feb03ad8efecdd2a837faa1a29dea2bacfd55" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_42220_0x65dd32834927de9e57e72a3e2130a19f81c6371d" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_42220_0x83dfeb42347a7ce46f1497f307a5c156d1f19cb2" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_42220_0xc06be1bbbeeaf2f34f3d5b76069d2560aee184ae" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_42220_0xeec0f3257369c6bcd2fd8755cbef8a95b12bc4c9" (
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

-- CreateTable
CREATE TABLE "t_sponsors_42220" (
    "contract" TEXT NOT NULL,
    "pk" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "t_sponsors_42220_pkey" PRIMARY KEY ("contract")
);

-- CreateIndex
CREATE INDEX "idx_events_100_contract" ON "t_events_100"("contract");

-- CreateIndex
CREATE INDEX "idx_events_100_contract_signature" ON "t_events_100"("contract", "event_signature");

-- CreateIndex
CREATE UNIQUE INDEX "t_events_100_contract_event_signature_key" ON "t_events_100"("contract", "event_signature");

-- CreateIndex
CREATE INDEX "idx_events_42220_contract" ON "t_events_42220"("contract");

-- CreateIndex
CREATE INDEX "idx_events_42220_contract_signature" ON "t_events_42220"("contract", "event_signature");

-- CreateIndex
CREATE UNIQUE INDEX "t_events_42220_contract_event_signature_key" ON "t_events_42220"("contract", "event_signature");

-- CreateIndex
CREATE INDEX "idx_logs_100_dest" ON "t_logs_100"("dest");

-- CreateIndex
CREATE INDEX "idx_logs_100_dest_date" ON "t_logs_100"("dest", "created_at");

-- CreateIndex
CREATE INDEX "idx_logs_100_tx_hash" ON "t_logs_100"("tx_hash");

-- CreateIndex
CREATE INDEX "idx_logs_42220_dest" ON "t_logs_42220"("dest");

-- CreateIndex
CREATE INDEX "idx_logs_42220_dest_date" ON "t_logs_42220"("dest", "created_at");

-- CreateIndex
CREATE INDEX "idx_logs_42220_tx_hash" ON "t_logs_42220"("tx_hash");

-- CreateIndex
CREATE INDEX "idx_logs_data_42220_hash" ON "t_logs_data_42220"("hash");

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
CREATE INDEX "idx_push_100_0x__f7a7f1_account" ON "t_push_token_100_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1"("account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__f7a7f1_token_account" ON "t_push_token_100_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_100_0x5815e61ef72c9e6107b5c5a05f_token_account_key" ON "t_push_token_100_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1"("token", "account");

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

-- CreateIndex
CREATE INDEX "idx_push_42220___99f156_account" ON "t_push_token_42220_0x56744910f7decd48c1a7fa61b4c317b15e99f156"("account");

-- CreateIndex
CREATE INDEX "idx_push_42220___99f156_token_account" ON "t_push_token_42220_0x56744910f7decd48c1a7fa61b4c317b15e99f156"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_42220_0x56744910f7decd48c1a7fa61_token_account_key" ON "t_push_token_42220_0x56744910f7decd48c1a7fa61b4c317b15e99f156"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_42220___f7a7f1_account" ON "t_push_token_42220_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1"("account");

-- CreateIndex
CREATE INDEX "idx_push_42220___f7a7f1_token_account" ON "t_push_token_42220_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_42220_0x5815e61ef72c9e6107b5c5a0_token_account_key" ON "t_push_token_42220_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_42220___acfd55_account" ON "t_push_token_42220_0x5f6feb03ad8efecdd2a837faa1a29dea2bacfd55"("account");

-- CreateIndex
CREATE INDEX "idx_push_42220___acfd55_token_account" ON "t_push_token_42220_0x5f6feb03ad8efecdd2a837faa1a29dea2bacfd55"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_42220_0x5f6feb03ad8efecdd2a837fa_token_account_key" ON "t_push_token_42220_0x5f6feb03ad8efecdd2a837faa1a29dea2bacfd55"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_42220___c6371d_account" ON "t_push_token_42220_0x65dd32834927de9e57e72a3e2130a19f81c6371d"("account");

-- CreateIndex
CREATE INDEX "idx_push_42220___c6371d_token_account" ON "t_push_token_42220_0x65dd32834927de9e57e72a3e2130a19f81c6371d"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_42220_0x65dd32834927de9e57e72a3e_token_account_key" ON "t_push_token_42220_0x65dd32834927de9e57e72a3e2130a19f81c6371d"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_42220___f19cb2_account" ON "t_push_token_42220_0x83dfeb42347a7ce46f1497f307a5c156d1f19cb2"("account");

-- CreateIndex
CREATE INDEX "idx_push_42220___f19cb2_token_account" ON "t_push_token_42220_0x83dfeb42347a7ce46f1497f307a5c156d1f19cb2"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_42220_0x83dfeb42347a7ce46f1497f3_token_account_key" ON "t_push_token_42220_0x83dfeb42347a7ce46f1497f307a5c156d1f19cb2"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_42220___e184ae_account" ON "t_push_token_42220_0xc06be1bbbeeaf2f34f3d5b76069d2560aee184ae"("account");

-- CreateIndex
CREATE INDEX "idx_push_42220___e184ae_token_account" ON "t_push_token_42220_0xc06be1bbbeeaf2f34f3d5b76069d2560aee184ae"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_42220_0xc06be1bbbeeaf2f34f3d5b76_token_account_key" ON "t_push_token_42220_0xc06be1bbbeeaf2f34f3d5b76069d2560aee184ae"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_42220___2bc4c9_account" ON "t_push_token_42220_0xeec0f3257369c6bcd2fd8755cbef8a95b12bc4c9"("account");

-- CreateIndex
CREATE INDEX "idx_push_42220___2bc4c9_token_account" ON "t_push_token_42220_0xeec0f3257369c6bcd2fd8755cbef8a95b12bc4c9"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_42220_0xeec0f3257369c6bcd2fd8755_token_account_key" ON "t_push_token_42220_0xeec0f3257369c6bcd2fd8755cbef8a95b12bc4c9"("token", "account");

