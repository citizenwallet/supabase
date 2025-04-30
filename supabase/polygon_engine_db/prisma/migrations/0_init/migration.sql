-- CreateTable
CREATE TABLE "t_events_100" (
    "contract" TEXT NOT NULL,
    "event_signature" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_events_137" (
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
CREATE TABLE "t_logs_137" (
    "hash" TEXT NOT NULL,
    "tx_hash" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "nonce" INTEGER NOT NULL,
    "sender" TEXT NOT NULL,
    "dest" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "data" JSONB,
    "status" TEXT NOT NULL DEFAULT 'success',

    CONSTRAINT "t_logs_137_pkey" PRIMARY KEY ("hash")
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
CREATE TABLE "t_logs_data_137" (
    "hash" TEXT NOT NULL,
    "data" JSONB,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "t_logs_data_137_pkey" PRIMARY KEY ("hash")
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
CREATE TABLE "t_push_token_137_0x05e2fb34b4548990f96b3ba422ea3ef49d5daa99" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_137_0x0d9b0790e97e3426c161580df4ee853e4a7c4607" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_137_0x58a2993a618afee681de23decbcf535a58a080ba" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_137_0x898c2737f2cb52622711a89d85a1d5e0b881bdea" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_137_0x8da817724eb6a2aa47c0f8d8b8a98b9b3c2ddb68" (
    "token" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "t_push_token_137_0xc2132d05d31c914a87c6611c10748aeb04b58e8f" (
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
CREATE TABLE "t_sponsors_100" (
    "contract" TEXT NOT NULL,
    "pk" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "t_sponsors_100_pkey" PRIMARY KEY ("contract")
);

-- CreateTable
CREATE TABLE "t_sponsors_137" (
    "contract" TEXT NOT NULL,
    "pk" TEXT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "t_sponsors_137_pkey" PRIMARY KEY ("contract")
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
CREATE INDEX "idx_events_137_contract" ON "t_events_137"("contract");

-- CreateIndex
CREATE INDEX "idx_events_137_contract_signature" ON "t_events_137"("contract", "event_signature");

-- CreateIndex
CREATE UNIQUE INDEX "t_events_137_contract_event_signature_key" ON "t_events_137"("contract", "event_signature");

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
CREATE INDEX "idx_logs_137_dest" ON "t_logs_137"("dest");

-- CreateIndex
CREATE INDEX "idx_logs_137_dest_date" ON "t_logs_137"("dest", "created_at");

-- CreateIndex
CREATE INDEX "idx_logs_137_tx_hash" ON "t_logs_137"("tx_hash");

-- CreateIndex
CREATE INDEX "idx_logs_42220_dest" ON "t_logs_42220"("dest");

-- CreateIndex
CREATE INDEX "idx_logs_42220_dest_date" ON "t_logs_42220"("dest", "created_at");

-- CreateIndex
CREATE INDEX "idx_logs_42220_tx_hash" ON "t_logs_42220"("tx_hash");

-- CreateIndex
CREATE INDEX "idx_logs_data_137_hash" ON "t_logs_data_137"("hash");

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
CREATE INDEX "idx_push_137_0x__5daa99_account" ON "t_push_token_137_0x05e2fb34b4548990f96b3ba422ea3ef49d5daa99"("account");

-- CreateIndex
CREATE INDEX "idx_push_137_0x__5daa99_token_account" ON "t_push_token_137_0x05e2fb34b4548990f96b3ba422ea3ef49d5daa99"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_137_0x05e2fb34b4548990f96b3ba422_token_account_key" ON "t_push_token_137_0x05e2fb34b4548990f96b3ba422ea3ef49d5daa99"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_137_0x__7c4607_account" ON "t_push_token_137_0x0d9b0790e97e3426c161580df4ee853e4a7c4607"("account");

-- CreateIndex
CREATE INDEX "idx_push_137_0x__7c4607_token_account" ON "t_push_token_137_0x0d9b0790e97e3426c161580df4ee853e4a7c4607"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_137_0x0d9b0790e97e3426c161580df4_token_account_key" ON "t_push_token_137_0x0d9b0790e97e3426c161580df4ee853e4a7c4607"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_137_0x__a080ba_account" ON "t_push_token_137_0x58a2993a618afee681de23decbcf535a58a080ba"("account");

-- CreateIndex
CREATE INDEX "idx_push_137_0x__a080ba_token_account" ON "t_push_token_137_0x58a2993a618afee681de23decbcf535a58a080ba"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_137_0x58a2993a618afee681de23decb_token_account_key" ON "t_push_token_137_0x58a2993a618afee681de23decbcf535a58a080ba"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_137_0x__81bdea_account" ON "t_push_token_137_0x898c2737f2cb52622711a89d85a1d5e0b881bdea"("account");

-- CreateIndex
CREATE INDEX "idx_push_137_0x__81bdea_token_account" ON "t_push_token_137_0x898c2737f2cb52622711a89d85a1d5e0b881bdea"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_137_0x898c2737f2cb52622711a89d85_token_account_key" ON "t_push_token_137_0x898c2737f2cb52622711a89d85a1d5e0b881bdea"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_137_0x__2ddb68_account" ON "t_push_token_137_0x8da817724eb6a2aa47c0f8d8b8a98b9b3c2ddb68"("account");

-- CreateIndex
CREATE INDEX "idx_push_137_0x__2ddb68_token_account" ON "t_push_token_137_0x8da817724eb6a2aa47c0f8d8b8a98b9b3c2ddb68"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_137_0x8da817724eb6a2aa47c0f8d8b8_token_account_key" ON "t_push_token_137_0x8da817724eb6a2aa47c0f8d8b8a98b9b3c2ddb68"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_137_0x__b58e8f_account" ON "t_push_token_137_0xc2132d05d31c914a87c6611c10748aeb04b58e8f"("account");

-- CreateIndex
CREATE INDEX "idx_push_137_0x__b58e8f_token_account" ON "t_push_token_137_0xc2132d05d31c914a87c6611c10748aeb04b58e8f"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_137_0xc2132d05d31c914a87c6611c10_token_account_key" ON "t_push_token_137_0xc2132d05d31c914a87c6611c10748aeb04b58e8f"("token", "account");

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

