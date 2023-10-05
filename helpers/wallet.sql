-- Create wallet table.
create table if not exists wallet (
    address varchar not null,
    chain_id varchar not null
);
alter table wallet add primary key (address, chain_id);

-- Seed with some example data.
insert into wallet (address, chain_id) values
('0x96706eb471f875a9a41442f358d3b34ba02f868b', '1'),
('0xb92e8732da4e2f742f5ee4352fac1480c49a5586', '1'),
('0xc316f415096223561e2077c30a26043499d579ad', '1'),
('0xe95330d7cdcd37bf0ad875c29e2a2871fefa3de8', '1'),
('0x8f7890032780cb8714fbc7814f0a03f4d2c87877', '1'),
('0x65a0af703047dfdd270361659d02f4f0e8547202', '1'),
('0xa8f96f0fdc54301c55d8df00fcd5139b29bf3458', '1'),
('0x9ee59b0f7687ed2b91bb0452d8d8759d576bc0d4', '1'),
('0xab54cc2ce408e6b7ad42629fc34567be859e9447', '1'),
('0x2906e0181f371b7a4c4bffe13e31b2a917b368e8', '1'),
('0x961aa96febee5465149a0787b03bfa14d8e9033f', '1'),
('0xa4ad2ee4f67c3c83a0081060b6aea2c88dfc36f3', '1'),
('0x72e1638bd8cd371bfb04cf665b749a0e4ae38324', '1'),
('0x2c32fb28dad2a1c08a1e6c82e861366fb5e311dd', '1'),
('0xfd4085f674b10c75da6ec7b5b11f185f0f567edc', '1'),
('0xca63608615de005339652c0eca93c5836eb0c2bd', '1'),
('0x29b1d432a40f40f5418da2d4abf740e5e491629b', '1'),
('0x7aa2dab71adef6e9172f836904fcd562e56da3b5', '1'),
('0x8dde317041a0154b53ef3f9d275b65c8c4273b40', '1'),
('0x3317ad9eda6942b5a7be5ba83346c0ea82c3c26c', '1'),
('0xbbfeb6968f818ae75f8765f24457c5414bcb9af3', '1'),
('0x07a145dbbc7e425d0f1b3b9982f955e97abad7a2', '1'),
('0xc19be75b8b9152d884987e1b58b3f18a94875396', '1'),
('0x045ff23cf3413f6a355f0acc6ec6cb2721b95d99', '1'),
('0x3abdc9ed5f5de6a74cfeb42a82087c853e160e76', '1'),
('0x8ae4a38768cb5c5b5f9f9aeca1b8009b587bda1a', '1'),
('0x32e5529ec5ac216a19db6f49b446c6df3337374e', '1'),
('0xca66dd641408f5e41a6ab6c7c8fcb243ff039a5c', '1'),
('0x1206ec7abf2c3d22051f6ebb249f065fc6436149', '1'),
('0x2c3b2b2325610a6814f2f822d0bf4dab8cf16e16', '1'),
('0x014eecfa2e58d4975991f46026a2332561161912', '1'),
('0x7824d4719b4b2d9034f09827d910ee2ac1f2fe0f', '1'),
('0xc42f8811d011e15e9c34399b5c1567a49d4caa45', '1'),
('0x302e2a0d4291ac14aa1160504ca45a0a1f2e7a5c', '1'),
('0xe7eebcbbd3087102a309f7efc5501859a24f8f75', '1');