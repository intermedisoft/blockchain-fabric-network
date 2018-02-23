# DEPA Healthcare Blockchain Network

การตั้งค่านี้เป็นการพัฒนาต่อยอดมาจากตัวอย่างจาก Hyperledger Fabric ["Build Your First Network"](http://hyperledger-fabric.readthedocs.io/en/latest/build_network.html) เพื่อใช้เป็นฐานในการรัน Blockchain Business Network ["DEPA Healthcare Business Network"](https://github.com/intermedisoft/blockchain-business-network)

## Physical Network Topology (การเชื่อมต่อทางกายภาพของ Blockchain Server)

[![physical-network-topology.png](https://s10.postimg.org/cqdnt0pcp/physical-network-topology.png)](https://postimg.org/image/9jj49e4wl/)

จาก Use Case ที่เราได้ออกแบบไว้ในโปรเจคนี้ เราจะมีผู้ให้บริการ 3 แห่งเข้ามาร่วมใน Blockchain Network โดยจะเป็น Mobile Application หนึ่งเจ้า และ HIS เป็นจำนวนสองเจ้า ดังนั้นเราจึงตั้ง Server ขึ้นมาเป็นจำนวน 3 เครื่อง เปรียบเสมือนว่าผู้ให้บริการแต่ละเจ้าได้สร้าง Peer ของตนเองขึ้นมา ในการนี้ เราจะใช้ Domain name เดียวกัน คือ ehrblox.com แต่แยกเครื่อง Server ด้วย Sub-Domain ที่แตกต่างกัน

* **PHR Application:** เป็น Agent เพื่อเป็นตัวแทนของผู้ใช้งาน โดยจะถือ Identity ของ User เอาไว้ และทำให้ผู้ใช้งานสามารถดูผลการตรวจสุขภาพ หรือให้สิทธิ์การเข้าถึงข้อมูลกับผู้ให้บริการรายอื่น ๆ ได้ โดยผู้ให้บริการรายนี้ได้ทำ Application ออกมาเป็น Progressive Web Application

* **Pensook's iMed Clinic (HIS) Broker:** Broker ของระบบ HIS ของคลินิกเป็นสุข ที่ซึ่งผู้ใช้งานระบบไปตรวจสุขภาพประจำปี และแพทย์ของคลินิกได้แนะนำให้ไปตรวจเพิ่มเติมที่โรงพยาบาลกรุงเทพภูเก็ต

* **BPK's iMed (HIS) Broker:** Broker ของระบบ HIS ของโรงพยาบาลกรุงเทพภูเก็ต โดยผลการตรวจจะถูกใส่ลงในระบบ Blockchain และถูกดูได้โดยแพทย์จากคลินิกเป็นสุข 

** สามารถดูรายละเอียดของ Application เหล่านี้ได้ที่ ["Blockchain PHR Application"](https://github.com/intermedisoft/blockchain-phr) และ ["Blockchain HIS Broker"](https://github.com/intermedisoft/blockchain-his-broker)

## Logical Components (ส่วนประกอบของโหนดในแต่ละ Server)

เพื่อที่จะสร้าง Blockchain Network ด้วย Hyperledger Fabric เราจำเป็นจะต้องรัน node ที่จำเป็นเหล่านี้ ได้แก่

* **Peers** ทำหน้าที่ในการรับ Request และส่ง Event ต่าง ๆ ระหว่าง Blockchain และ Third Party Application อีกทั้งยังทำหน้าที่เป็น Digital Ledger เพื่อจดบันทึก Transaction ที่เกิดขึ้นใน Blockchain Network ทั้งหมด
* **Orderers** ทำหน้าที่ในการจัดเรียงและตรวจสอบความถูกต้อง Transaction และจัดเก็บข้อมูลเป็น Block กระจายไปยัง Peer Node ต่าง ๆ
* **Certificate Authority** ทำหน้าที่ในการตรวจสอบอัฒลักษณ์บุคคล (Identity) ของผู้ใช้ระบบ เพื่อเป็นการระบุบุคคลผู้ใช้งาน

นอกจากนี้ยังมีส่วนเสริม เพื่อจัดเก็บข้อมูล คือ

* **CouchDB**: เพื่อเป็นฐานข้อมูลให้กับ Peer Node โดยจะรันอยู่คู่กับ Peer Node เสมอ
* **REST Server และ MongoDB**: เพิ่มช่องทางการเข้าถึง Blockchain Network โดยทำให้ผู้พัฒนา Application สามารถเข้าถึงข้อมูลได้โดยการเรียกผ่าน REST API แทนการใช้งาน Hyperledger Fablic SDK เพื่อคุยกับ Peer โดยตรง

[![logical-network-component.png](https://s10.postimg.org/hc9s1edgp/logical-network-component.png)](https://postimg.org/image/r9ksugl2d/)

ภาพข้างต้นเป็นการแสดง Logical Components ที่ทำงานอยู่บนแต่ละ Physical Server โดยหลัก ๆ จะมี Peer และ REST Server เพื่อใช้งานภายในองค์กร, CA แยกกันในแต่ละองค์กรเพื่อที่จะสามารถออก Identity ให้กับผู้ใช้งานในองค์กรได้ แต่เนื่องจาก Orderer เป็น Node ที่ใช้ในการเชื่อมต่อกันระหว่างองค์กร ดังนั้นจึงสามารถใช้งานร่วมกันได้ และเราจำลองให้วางไว้ใน Server ของ PHR Application

## Deploy Network (การรันเน็ตเวิร์ก)

จากการออกแบบข้างต้น ทำให้เราจะต้องมีเครื่อง Server 3 เครื่อง และการตั้งค่าที่แตกต่างออกไปหากท่านผู้ที่สนใจต้องการที่จะนำไปรันเอง ขั้นตอนที่แนะนำเพื่อจะสร้างเน็ตเวิร์กเช่นเดียวกันนี้ สามารถทำได้โดย

1. รัน Script `scripts/01_install_binaries.sh` เพื่อที่จะติดตั้งสิ่งที่จำเป็นในการตั้งค่าระบบเน็ตเวิร์ก
2. แก้ไขไฟล์ `configtx.yaml`, `crypto-config.yaml` เพื่อกำหนดชื่อ Domain ที่จะใช้ ตั้งค่าการเชื่อมต่อระหว่าง Node ภายใน Network และสร้าง Cryptography Key ให้แต่ละ Node
3. แก้ไขและรัน Script `scripts/02_run_genscript.sh` เพื่อทำการสร้าง Key จากไฟล์ Config จากข้อ 2
4. แก้ไขไฟล์ `base/peer-base.yaml`, `base/docker-composer-base.yaml`, `docker-compose-*.yaml` ให้สอดคล้องกับไฟล์ Config จากข้อ 2 และ Key ที่ได้จากข้อ 3
5. นำ Project นี้ทั้งหมดไปวางไว้แต่ละเครื่อง และรันไฟล์ `docker-composer-*.yaml` สำหรับแต่ละโหนด
6. รันคำสั่งที่ได้จากการรัน Script `scripts/04_join_channel.sh` เพื่อ Join Channel ในแต่ละ Node

## Create Identities (การสร้างตัวตนผู้ดูแลระบบ)

เนื่องจาก Smart Contract (chaincode) ที่เราต้องการจะรัน เราจะใช้เครื่องมือที่ชื่อว่า Hyperledger Composer เพื่อเขียนเป็น Business Network Definition และจะถูกแปลงมาเป็น chaincode ดังนั้นเราจึงต้องรันคำสั่งเพื่อสร้าง Identity ของผู้ดูแล Peer ซึ่งจะมีหน้าที่ในการ Deploy Business Network ดังกล่าว มีขั้นตอนดังนี้

0. ติดตั้ง Hyperledger Composer CLI
1. สร้าง connection.json โดยมีเนื้อหาดังนี้ (ปรับแก้ตามจำเป็น)
```
{
	"name" : "hlfv1",
	"type" : "hlfv1",
	"orderers" : [{
			"url" : "grpcs://ehrblox.com:7050"
		}
	],
	"ca" : {
		"url" : "https://ehrblox.com:7054",
		"name" : "ca.phr.ehrblox.com"
	},
	"peers" : [{
			"requestURL" : "grpcs://ehrblox.com:7051",
			"eventURL" : "grpcs://ehrblox.com:7053"
		}
	],
	"channel" : "depachannel",
	"mspID" : "PHRMSP",
	"timeout" : 300
}
```
2. รันคำสั่ง `composer card create -p connection.json -u PeerAdmin -c crypto-config/peerOrganizations/phr.ehrblox.com/users/Admin@phr.ehrblox.com/msp/admincerts/Admin@phr.ehrblox.com-cert.pem -k crypto-config/peerOrganizations/phr.ehrblox.com/users/Admin@phr.ehrblox.com/msp/keystore/ -r PeerAdmin -r ChannelAdmin` (ปรับแก้ตามจำเป็น) จะได้ไฟล์ PeerAdmin@hlfv1.card
3. รันคำสั่ง `composer card import -f PeerAdmin@hlfv1.card` เพื่อนำเข้ามาใช้งาน

## การ Deploy Business Network

กรุณาดูรายละเอียดใน ["DEPA Healthcare Business Network"](https://github.com/intermedisoft/blockchain-business-network)
