
ibeacon����
ɨ�赽ibeacon����Ϣ
http://127.0.0.1/zld/ibeaconhandle.do?action=regibc&uuid=88888&mobile=15801482643
�ύ����
http://127.0.0.1/zld/ibeaconhandle.do?action=balance&orderid=1&uid=1000010&comid=3&total=96&carnumber=��GPS223

//�������� 
===========5��4-9��=============
1�����ͣ����ע�ᣬ�޸ģ���ѯ ��ɾ���ȹ��ܣ��ܹ���Ա��
2����ɳ�������Աע���Ա���շ�Ա�����񣩣�ɾ����Ա���޸�����
3����ɳ�ע�ᣬ��¼
4����ɶ������� ��(��̨����)
===========5��12-16��===========
1:�ͻ������ܹ���Ա��
2���������� �� ���(�복���ֻ����뽻������) 
3����ֵ���� 


����  �������Żݣ���

ͣ��������˾��

�û�����

ͣ���Ѽ۸����Ʒ��


===������===============

CREATE TABLE price_tb ---�۸��
(
  id bigint NOT NULL,
  comid bigint,
  price numeric(10,2),
  state bigint DEFAULT 0,
  unit integer,
  pay_type integer, -- �շ����ͣ���ʱ�䣬���죬���£�����������
  CONSTRAINT product_tb_pkey PRIMARY KEY (id)
)
*******************************************

CREATE TABLE product_package_tb  --ͣ�������²�Ʒ��
(
  id bigint,
  valid_time character varying(30),
  b_time integer,
  e_time integer,
  remain_number integer, -- ʣ������
  state integer DEFAULT 0, -- 0:�����ã�1������
  comid bigint,
  price numeric(10,2)
)

*******************************************
ibeacon_tb --�����豸

id --��ţ�������������
ibcid --������ţ���Ӧibeacon��Mac
buy_time --��������
state --״̬

*******************************************

area_ibeacon_tb --ͣ��������

id --��ţ�������������
ibcid --������ţ���Ӧibeacon��Mac
comid --ͣ�������
reg_time --ע������
in_out --����/���
state --״̬

*******************************************

park_charge_tb --�շ���ˮ��

id --��ţ�������������
comid --ͣ�������
create_tiime --�շ�����
amount --���
uin --�ͻ��ʺ�

*******************************************

withdrawer_tb  ���ּ�¼��

id --��ţ�������������
comid --ͣ�������
create_tiime --�շ�����
amount --���

*******************************************

recharge_tb --��ֵ

id --��ţ�������������
uin --�ͻ��ʺ�
amount --���
charge_type --��ֵ����
create_tiime --��ֵ����

*******************************************


car_info_tb  ---������Ϣ��

id --��ţ�������������
uin --����
car_number --����
is_use --��ǰʹ��


*******************************************
ͣ���������

������ҵ

��λ����

��λ����

��������

���꣨��ͼ���꣬���ڲ��Ҹ���ͣ������

�Ƿ�ֱ����ɶ������������Żݣ�


*******************************************






*******************************************
�����շ�Ա

url:http://127.0.0.1/zld/collectorrequest.do?

http://s.zhenlaidian.com/zld/collectorlogin.do?username=1000005&password=666666

//����λ
action=toshare&token=dfc7f35f92014d229eee55634648bd3f&s_number=1000
//��˾��Ϣ
action=cominfo&token=*
//�ֽ��շ�
action=ordercash&token=*&orderid=*
//��ʷ����
http://s.zhenlaidian.com/zld/collectorrequest.do?action=orderhistory&token=f7d3d26b60eaa9a57d4f1f64713d9b19&page=1&size=10
//��ǰ����
http://s.zhenlaidian.com/zld/collectorrequest.do?action=currorders&token=f7d3d26b60eaa9a57d4f1f64713d9b19&page=1&size=10
//��������
action=orderdetail&token=*&orderid=*
//���۴���
action=tosale&token=*&orderid=*&hour=*

http://s.zhenlaidian.com/zld/collectorrequest.do?action=cominfo&token=dfc7f35f92014d229eee55634648bd3f&s_number=1000


*********************************************************
����
===========================================================

1����¼��
 *������¼��ע�ᣬ��֤�봦��
 * �����룬����xml��ʽ��
 * 1:��¼�ɹ���
 * 0:������֤�룬
 * -1����֤����Ч��
 * -2��ע��ʧ�ܣ�
 * -3�����ֻ�������֤��ʧ�ܣ�
 * -4����ɫ����
 * -5:�ֻ��������
 * -6��ϵͳ��֤�벻����
 * -7:������֤�����
 http://s.zhenlaidian.com/zld/carlogin.do?action=login&mobile=15801482643
 http://192.168.1.103/zld/carlogin.do?action=login&mobile=15801482643
 http://192.168.1.103/zld/carlogin.do?action=validcode&code=1715&mobile=15801482643
 http://s.zhenlaidian.com/zld/carlogin.do?action=validcode&code=1630&mobile=15801682643

 ============================================================
2�������ӷ�����ȡ����
 http://192.168.1.104/zld/carservice.do?action=getparking&begintime=utcʱ�䣬����
 http://s.zhenlaidian.com/zld/carservice.do?action=getparkshare&ids=

 
 ============================================================
3��ɨ�赽Ibeaconʱ�����󶩵�
 * ����ֵinfo�ڵ�˵����
	 *  7:δ��ͨת�˽ӿ�
	 * 	6���ֽ�֧�� ���ȴ��շ�Ա��Ǯ
	 *  5:�������ѳɹ�
	 *  4:�����½��ɹ� 
	 *  3:������û�пɽ���Ķ��� 
	 *  2:�Ѵ��ڸ�ͣ����δ����Ķ������������ɽ������� 
	 *  1:��������
	 *  0�����㶩�� 
	 *  -1��uuid Ϊ�� 
	 *  -2��uuid δע�� 
	 *  -3:uuid ������
	 *  -4:�����ֻ���Ϊ�� 
	 *  -5:�����ֻ���δע��
	 *  -6:�½���������
	 *  -7:�����շѴ���
	 *  -8:�����ѽ��㣬������������
	 *  -9:����������
	 *  -10:ͣ���������� 
	 *  -11:֧����ʽ����
	 *  -12:�˻�����
����ɨ�赽ibeacon
http://s.zhenlaidian.com/zld/ibeaconhandle.do?action=regibc&uuid=*
������uuid:ibeacon uuid
���أ�
������
info:1
parkname:��������
parkaddress:������ַ
begin:����ʱ��
comid:��˾���
uin:�������
balance:�����ʻ����
carnumber:�������ƺ�
message:��Ϣ��ʾ

�볡��
info:0
parkname:��������
parkaddress:������ַ
begin:����ʱ��
end:�볡ʱ��
duration:ʱ����Сʱ��
total:���
issale:�Ƿ����
orderid:�������
carnumber:�������ƺ�
message:��Ϣ��ʾ


�������ɶ���
http://s.zhenlaidian.com/zld/ibeaconhandle.do?action=addorder&comid=&uin=&balance=

������
comid:��˾ID
uin:������� 
balance:�����ʻ����

���أ�
info:4
message:��ʾ��Ϣ


 �������㶩�� 
http://s.zhenlaidian.com/zld/ibeaconhandle.do?action=doorder&comid=&uin=&balance=&duration&orderid=&is_sale=&total=&carnumber&pay_type= 

������
comid:��˾ID
uin:������� 
balance:�����ʻ����
duration:ʱ����Сʱ��
orderid:�������
issale:�Ƿ����
pay_type:֧����ʽ:0:�˻����֧�� ��1:ת�ˣ�2���ֽ�֧�� 

���أ�
info:4
message:��Ϣ��ʾ