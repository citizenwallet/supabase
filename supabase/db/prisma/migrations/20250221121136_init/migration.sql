-- CreateTable
CREATE TABLE "a_members" (
    "account" TEXT NOT NULL,
    "contract" TEXT NOT NULL,
    "username" TEXT NOT NULL DEFAULT 'anonymous',
    "name" TEXT NOT NULL DEFAULT 'Anonymous',
    "description" TEXT NOT NULL DEFAULT 'this user does not have a profile',
    "image" TEXT NOT NULL DEFAULT 'https://ipfs.internal.citizenwallet.xyz/QmeuAaXrJBHygzAEHnvw5AKUHfBasuavsX9fU69rdv4mhh',
    "image_medium" TEXT NOT NULL DEFAULT 'https://ipfs.internal.citizenwallet.xyz/QmeuAaXrJBHygzAEHnvw5AKUHfBasuavsX9fU69rdv4mhh',
    "image_small" TEXT NOT NULL DEFAULT 'https://ipfs.internal.citizenwallet.xyz/QmeuAaXrJBHygzAEHnvw5AKUHfBasuavsX9fU69rdv4mhh',
    "token_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "a_members_pkey" PRIMARY KEY ("account","contract")
);
