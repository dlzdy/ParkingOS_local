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
product_tb --ͣ���Ѽ۸��

id --��ţ�������������
comid --��˾���
price --�۸�
state --״̬   0��ǰ�����ã�1��ǰ����

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




---����������
CREATE SEQUENCE seq_ibeacon_tb
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_ibeacon_tb
  OWNER TO postgres;


CREATE OR REPLACE FUNCTION trigger_fct_ibeacon_tb_trigger()
  RETURNS trigger AS
$BODY$
BEGIN
  if new.id is NULL then
New.id:=nextval('seq_ibeacon_tb');
end if;
Return NEW;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION trigger_fct_ibeacon_tb_trigger()
  OWNER TO postgres;


CREATE TRIGGER ibeacon_tb_trigger
  BEFORE INSERT
  ON ibeacon_tb
  FOR EACH ROW
  EXECUTE PROCEDURE trigger_fct_ibeacon_tb_trigger();