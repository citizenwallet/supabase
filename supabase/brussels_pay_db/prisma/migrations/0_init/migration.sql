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
CREATE TABLE "t_push_token_100_0x56cc38bda01be6ec6d854513c995f6621ee71229" (
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
CREATE INDEX "idx_push_100_0x__e71229_account" ON "t_push_token_100_0x56cc38bda01be6ec6d854513c995f6621ee71229"("account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__e71229_token_account" ON "t_push_token_100_0x56cc38bda01be6ec6d854513c995f6621ee71229"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_100_0x56cc38bda01be6ec6d854513c9_token_account_key" ON "t_push_token_100_0x56cc38bda01be6ec6d854513c995f6621ee71229"("token", "account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__f7a7f1_account" ON "t_push_token_100_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1"("account");

-- CreateIndex
CREATE INDEX "idx_push_100_0x__f7a7f1_token_account" ON "t_push_token_100_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1"("token", "account");

-- CreateIndex
CREATE UNIQUE INDEX "t_push_token_100_0x5815e61ef72c9e6107b5c5a05f_token_account_key" ON "t_push_token_100_0x5815e61ef72c9e6107b5c5a05fd121f334f7a7f1"("token", "account");

