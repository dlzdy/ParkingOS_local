/*******************************************************************************
 * Copyright (c) 2015 by ehoo Corporation all right reserved.
 * 2015��4��13�� 
 * 
 *******************************************************************************/
package com.zld.fragment;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;
import android.widget.RadioButton;
import android.widget.Toast;

import com.google.gson.Gson;
//import com.handmark.pulltorefresh.library.PullToRefreshBase;
//import com.handmark.pulltorefresh.library.PullToRefreshListView;
import com.zld.R;
import com.zld.adapter.CurrentOrderAdapter;
import com.zld.bean.AllOrder;
import com.zld.bean.AppInfo;
import com.zld.bean.CarBitmapInfo;
import com.zld.bean.CarNumberOrder;
import com.zld.bean.CurrentOrder;
import com.zld.lib.constant.Constant;
import com.zld.lib.dialog.DialogManager;
import com.zld.lib.dialog.ToastManager;
import com.zld.lib.http.HttpManager;
import com.zld.lib.http.RequestParams;
import com.zld.lib.state.ComeInCarState;
import com.zld.lib.state.OrderListState;
import com.zld.lib.util.FileUtil;
import com.zld.lib.util.SharedPreferencesUtils;
import com.zld.lib.util.StringUtils;
import com.zld.lib.util.TimeTypeUtil;
import com.zld.lib.util.VoicePlayer;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

//import com.zld.local.bean.LocalCurrentOrder;

/**
 * <pre>
 * ����˵��: 
 * ����:	2015��4��13��
 * ������:	HZC
 * 
 * ��ʷ��¼
 *    �޸����ݣ�
 *    �޸���Ա��
 *    �޸����ڣ� 2015��4��13��
 * </pre>
 */
public class OrderListFragment extends BaseFragment implements OnClickListener {
	public static final String REFRESH_ITEM = "REFRESH_ITEM";
	private static final String TAG = "OrderListFragment";
	private OrderListListener myListener;
	private View mainView;
	private int page = 1;
	private int size = 10;
	private AllOrder itemOrder;
	private boolean auto=false;
	private CurrentOrder orders;
	private boolean isShowFirstItem;
	private CurrentOrderAdapter adapter;
	public  OrderListState orderListState;
//	private PullToRefreshListView lv_current_order;
	private RadioButton[] rbs = new RadioButton[2];
	private int listFlag = 0;//listview ��ʾ�����ڳ������볡�ı��
	//�Զ������ĳ��ƺţ���¼������ԭ�������ƥ�䲻�ϻ�Ҫƥ���м����λ�ַ�
	private String searchCarNumber;
	private int j=0;//���Զ����б�ʧ��

	@SuppressLint("HandlerLeak")
	private Handler handler = new Handler(){
		public void handleMessage(Message msg) {
			switch (msg.what) {
			case Constant.LIST_REFRESH:
				@SuppressWarnings("unchecked")
				ArrayList<AllOrder> localorders  = (ArrayList<AllOrder>) msg.obj;
				int type = msg.arg1;
				localOrderShow(localorders,type);
				break;

			default:
				break;
			}
		}
	};
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		mainView = inflater.inflate(
				R.layout.pulltorefreshlistview, container,false);
//		initView();
		registerBr();
		initComid();
		return mainView;
	}

	private void initComid() {
		String comid = SharedPreferencesUtils.getParam(
				activity.getApplicationContext(), "zld_config", "comid", null);
		AppInfo.getInstance().setComid(comid);
	}

	@Override
	public void onStart() {
		// TODO Auto-generated method stub
		super.onStart();
		rbs[0].performClick();
	}

	@Override
	public void onAttach(Activity activity) {
		// TODO Auto-generated method stub
		super.onAttach(activity);
		myListener = (OrderListListener) activity;
	}

	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		super.onActivityCreated(savedInstanceState); 
	}

//	private void initView() {
//		rbs[0] = (RadioButton) mainView.findViewById(R.id.in_park_cars);
//		rbs[1] = (RadioButton) mainView.findViewById(R.id.out_park_cars);
//		for (int i = 0; i < rbs.length; i++) {
//			rbs[i].setTag(i);
//			rbs[i].setOnClickListener(this);
//		}
//		orderListState = OrderListState.getInstance();
//		adapter = new CurrentOrderAdapter(getActivity(), null);
//		lv_current_order = (PullToRefreshListView) mainView
//				.findViewById(R.id.pulltorefreshListView);
//		lv_current_order.setMode(PullToRefreshBase.Mode.BOTH);
//		lv_current_order.setAdapter(adapter);
//		lv_current_order.setOnRefreshListener(
//				new PullToRefreshBase.OnRefreshListener2<ListView>() {
//					@Override
//					public void onPullDownToRefresh(
//							PullToRefreshBase<ListView> refreshView) {
//						if (listFlag == 0){
//							/*�ֶ�ˢ��,�л������¿��û�״̬,����������,�ֶ�ˢ�²�����*/
//							activity.setDetailInCarState(ComeInCarState.MANUAL_REFRESH_ORDER_LIST);
//							getOrderInPark(true);
//						}else if (listFlag == 1){
//							getHistoryOrder(true);
//						}
//					}
//
//					@Override
//					public void onPullUpToRefresh(
//							PullToRefreshBase<ListView> refreshView) {
//						if (listFlag == 0){
//							getOrderInPark(false);
//						}else if (listFlag == 1){
//							getHistoryOrder(false);
//						}
//					}
//				});
//		lv_current_order.setOnItemClickListener(new OnItemClickListener() {
//			@Override
//			public void onItemClick(AdapterView<?> parent, View view,int position, long id) {
//				if(position == 0){
//					activity.showToast("��ˢ���б�");
//					return;
//				}
//				itemOrder = adapter.getAllOrders(position);
//				adapter.highLightSelectedItem(position);
//				Log.e("OrderListState", "��ǰ״̬Ϊ��"+orderListState.getState());
//				if(OrderListState.getInstance().isParkOutState()){
//					setOrderDetails();
//				}else{
//					if(itemOrder != null){
//						clearOrthersFragment();
//						cashOrder(0,itemOrder.getId(),itemOrder.getLocalid());
//					}else{
//						activity.showToast("��ˢ���б�");
//					}
//				}
//			}
//		});
//	}

	public AllOrder getItemOrder() {
		return itemOrder;
	}

	public void setItemOrder(AllOrder itemOrder) {
		this.itemOrder = itemOrder;
	}

	public boolean isAuto() {
		return auto;
	}

	public void setAuto(boolean auto) {
		this.auto = auto;
	}

	/**
	 * ���ö�������
	 */
	private void setOrderDetails() {
		CarNumberOrder carNumberOrder = allOrderChangeCarNumber();
		myListener.refreshCashView(carNumberOrder);
		myListener.refreshDetailView(carNumberOrder);
		myListener.refreshRecordView(carNumberOrder);
	}

	/**
	 * �������fragment��view
	 */
	public void clearOrthersFragment(){
		myListener.refreshCashView(null);
		myListener.refreshDetailView(null);
		myListener.refreshRecordView(null);
	}

	/**
	 * �����б�㲥
	 */
	private void registerBr() {
		IntentFilter intentFilter = new IntentFilter();
		intentFilter.addAction(REFRESH_ITEM);
		activity.registerReceiver(new ListReceiver(), intentFilter);
	}

	/**
	 * �ڳ��볡ѡ�
	 * @param position
	 */
	private void setRadioChecked(int position) {
		for (int i = 0; i < rbs.length; i++) {
			rbs[i].setChecked(i == position);
		}
		switch (position) {
		case 0:
			//��ǰ�����ڳ��б�
			listFlag = 0;
			changeRadioBtnColor(position);
			/*�ֶ�ˢ��,�л������¿��û�״̬,����������,�ֶ�ˢ�²�����*/
			activity.setDetailInCarState(ComeInCarState.MANUAL_REFRESH_ORDER_LIST);
			getOrderInPark(true);
			break;
		case 1:
			//��ǰ�����볡�б�
			listFlag = 1;
			changeRadioBtnColor(position);
			getHistoryOrder(true);
			break;
		}
		Log.e(TAG, "�б��л�ʱ,���ݵ�ǰ״̬,��ʾor���ذ�ť");
		activity.showOrHideBtn();
	}

	/**
	 * �ı�RadioBtn��ɫ
	 * @param position
	 */
	public void changeRadioBtnColor(int position) {
		for (int i = 0; i < rbs.length; i++) {
			if(i == position){
				rbs[i].setBackgroundColor(
						activity.getResources().getColor(R.color.white));
				rbs[i].setTextColor(this.getResources().getColor(R.color.dark_grenn));
			}else{
				rbs[i].setBackgroundColor(
						activity.getResources().getColor(R.color.dark_grenn));
				rbs[i].setTextColor(this.getResources().getColor(R.color.white));
			}
		}
	}

	/**
	 * �ֶ������ͳ���ʶ����Զ��������㹫�÷�������Ҫ����״̬��listview
	 * @param carnumber
	 * @param orderListState
	 */
	public void searchCarNumber(String carnumber, int orderListState) {
		FileUtil.writeSDFile("������������", "��searchCarNumber  "+carnumber +"  orderListState:"+orderListState);
		Log.e(TAG, "����Fragment�����ĳ��ƺţ�"+carnumber);
		searchCarNumber = carnumber;
		this.orderListState.setState(orderListState);
		try {
			if(carnumber == null){
				activity.showToast("��������Ҫ�����ĳ��ƺţ�");
				return;
			}
			searchCarNumberOrder(carnumber);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * �������ϻ�ȡ��ǰ������
	 * @param isRrefrech �Ƿ�ˢ��
	 */
	public void getOrderInPark(boolean isRrefrech) {
		if(this.orderListState != null){
			this.orderListState.setState(OrderListState.PARK_IN_STATE);
		}
		isShowFirstItem = isRrefrech;
		if (isRrefrech) {
			page = 1;
			adapter.removeOrders();
			adapter.setSelectedPosition(0);
		} else {
			page++;
		}
		//�Ƿ��Ǳ��ط�����
		Log.e(TAG,"===getIsLocalServer:"+!AppInfo.getInstance().getIsLocalServer(activity));
		if(!AppInfo.getInstance().getIsLocalServer(activity)){//�Ǳ��ط�������û��ƽ�屾�ػ��ĸ���
			boolean isLocal = SharedPreferencesUtils.getParam(
					activity.getApplicationContext(),"nettype", "isLocal", false);
			Log.e("isLocal","OrderListFragment getOrderInPark get isLocal "+isLocal);
//			Log.e(TAG,"���ض����б�"+AppInfo.getInstance().getIssuplocal());
//			if (isLocal||AppInfo.getInstance().getIssuplocal().equals(Constant.sOne)) {
//				doGetOrdersTimeOut(0);
//				return;
//			}
		}

		RequestParams params = new RequestParams();
		params.setUrlHeader(Constant.requestUrl + Constant.GET_CURRORDER);
		params.setUrlParams("comid", AppInfo.getInstance().getComid());
		params.setUrlParams("page", page);
		params.setUrlParams("size", size);
		params.setUrlParams("through", 3);
		String url = params.getRequstUrl();
		Log.e(TAG, "�ڳ����������б�url---------------->>" + url);
		DialogManager.getInstance().showProgressDialog(activity,
				"��ȡ�ڳ�����...");
		HttpManager.requestGET(getActivity(), url, this);
	}

	/**
	 * �������ϻ�ȡ��ʷ����;
	 * @param isRrefrech
	 */
	private void getHistoryOrder(boolean isRrefrech) {
		if(this.orderListState != null){
			this.orderListState.setState(OrderListState.PARK_OUT_STATE);
		}
		isShowFirstItem = isRrefrech;
		if (isRrefrech) {
			page = 1;
			adapter.removeOrders();
			adapter.setSelectedPosition(0);
		} else {
			page++;
		}

		//		�Ƿ��Ǳ��ط�����
		//		if(!AppInfo.getInstance().getIsLocalServer(activity)){//�Ǳ��ط�������û��ƽ�屾�ػ��ĸ���
		//		// ���ػ�
		//		boolean param = SharedPreferencesUtils.getParam(
		//		activity.getApplicationContext(),"nettype", "isLocal", false);
		//		Log.e("isLocal","OrderListFragment getHistoryOrder get isLocal "+param);
		//		if (param) {
		//			Log.e(TAG,"��ʷ�����б�");
		//			return;
		//		}
		//	}

		RequestParams params = new RequestParams();
		params.setUrlHeader(Constant.requestUrl + Constant.ORDER_HISTORY);
		params.setUrlParams("token", AppInfo.getInstance().getToken());
		params.setUrlParams("page", page);
		params.setUrlParams("size", size);
		params.setUrlParams("uid", AppInfo.getInstance().getUid());
		params.setUrlParams("day", "today");
		params.setUrlParams("ptype", 1);
		params.setUrlParams("out", "json");
		String url = params.getRequstUrl();
		Log.e(TAG, "�볡���������б�url---------------->>" + url);
		DialogManager.getInstance().showProgressDialog(getActivity(),
				"��ȡ�볡���������б�...");
		HttpManager.requestGET(getActivity(), url, this);
	}

	/**
	 * �������복�ƺ�,��ѯ���ϵĶ���
	 * @param carNumber
	 * @throws UnsupportedEncodingException 
	 */
	public void searchCarNumberOrder(String carNumber) throws UnsupportedEncodingException{
		//�Ƿ��Ǳ��ط�����
		if(!AppInfo.getInstance().getIsLocalServer(activity)){//�Ǳ��ط�������û��ƽ�屾�ػ��ĸ���
			//���ػ�
			boolean param = SharedPreferencesUtils.getParam(
					activity.getApplicationContext(), "nettype", "isLocal", false);
			Log.e("isLocal","OrderListFragment searchCarNumberOrder get isLocal "+param);
			if(param||AppInfo.getInstance().getIssuplocal().equals(Constant.sOne)){
				Log.e("OrderListState", "��ǰ״̬2Ϊ�ֶ�,3Ϊ�Զ���"+orderListState.getState());
				if(orderListState.getState() == OrderListState.HAND_SEARCH_STATE){
//					doHandSearchTimeOut(carNumber);
				}else if(orderListState.getState() == OrderListState.AUTO_SEARCH_STATE){
//					activity.doAutoSearchTimeOut(activity.resultBitmap,0, carNumber);
				}
				return;
			}
		}
		String ecodeCarNumber = URLEncoder.encode(URLEncoder.encode(carNumber, "utf-8"),"utf-8");
		RequestParams params = new RequestParams();
		params.setUrlHeader(Constant.requestUrl +  Constant.QUERY_ORDER);
		params.setUrlParams("comid", AppInfo.getInstance().getComid());
		params.setUrlParams("carnumber", ecodeCarNumber);
		params.setUrlParams("uid", AppInfo.getInstance().getUid());
		params.setUrlParams("through", 3);
		params.setUrlParams("search", 2);//1.2.4�汾Ϊ0  1.2.5�汾����Ϊ2
		String url = params.getRequstUrl();
		Log.e(TAG, "���ݳ��ƺŲ�ѯ������url---------------->>" + url);
		DialogManager.getInstance().showProgressDialog(getActivity(),
				"��������...");
		FileUtil.writeSDFile("������������", "��searchCarNumberOrder   carNumber:"+ carNumber +" url:"+url);
//		HttpManager.UpLogs(getActivity(),"���̣�searchCarNumberOrder   carNumber:"+ carNumber +" url:"+url);
		HttpManager.requestGET(getActivity(), url,carNumber, this);			
	}

//	private void doHandSearchTimeOut(String carNumber) {
//		//�����޸�
//		ArrayList<AllOrder> orders = loDBManager.queryLocalLikeAllOrderBycarNumber(0,carNumber,null);
//		//�������Ķ����б�ˢ����ʾ
//		if (orders == null||orders.size() == 0){
//			adapter.removeOrders();
//			clearOrthersFragment();
//			itemOrder = null;
//			ToastManager.getInstance().showToast(activity, "�޴˶���...", Toast.LENGTH_LONG);
//			return;
//		}else{
//			Log.e(TAG, "�����������Ķ�����"+orders.toString());
//			orders = selectMonthUser(orders);
//			adapter.removeOrders();
//			adapter.addOrders(orders);
//			adapter.setSelectedPosition(0);
//			if(orders.get(0)!= null){
//				itemOrder = orders.get(0);
//				cashOrder(0,itemOrder.getId(),itemOrder.getLocalid());
//			}
//		}
//	}

	/**
	 * ��Ѷ���
	 */
	private void freeOrder() {
		RequestParams params = new RequestParams();
		params.setUrlHeader(Constant.requestUrl + Constant.FREE_ORDER);
		params.setUrlParams("token", AppInfo.getInstance().getToken());
		params.setUrlParams("orderid", itemOrder.getId());
		params.setUrlParams("passid", activity.passid);
		params.setUrlParams("isPolice", 1);
		String url = params.getRequstUrl();
		Log.e(TAG, "��Ѷ�����url��--->"+url);
		HttpManager.requestGET(getActivity(), url, this);
	}


	/**
	 * �Ѷ������ύ����������ȡ��������;
	 */
	public void cashOrder(int type,String orderid,String localid){
		//�Ƿ��Ǳ��ط�����
		if(!AppInfo.getInstance().getIsLocalServer(activity)){//�Ǳ��ط�������û��ƽ�屾�ػ��ĸ���
			boolean param = SharedPreferencesUtils.getParam(
					activity.getApplicationContext(),"nettype", "isLocal", false);
			Log.e("isLocal","OrderListFragment cashOrder get isLocal "+param);
			if (param||AppInfo.getInstance().getIssuplocal().equals(Constant.sOne)) {
				// ���ػ����
//				doCashOrderTimeOut(type,orderid,localid);
				return;
			}
		}
		RequestParams params = new RequestParams();
		params.setUrlHeader(Constant.requestUrl + Constant.CAT_ORDER);
		params.setUrlParams("comid", AppInfo.getInstance().getComid());
		params.setUrlParams("orderid", orderid);
		params.setUrlParams("ptype", 1);
		String url = params.getRequstUrl();
		Log.e(TAG, "���ݶ����Ż�ȡ��������url---------------->>" + url);
		DialogManager.getInstance().showProgressDialog(getActivity(),
				"��ȡ��������...");
		FileUtil.writeSDFile("������������", "��doAutoSearchResult��ֻ��Ӧ��һ��������ʼ���ӿ�cashOrder/catorder   orderid:"+ orderid +"  localid"+localid+" url:"+url);
//		HttpManager.UpLogs(getActivity(),"���̣�doAutoSearchResult��ֻ��Ӧ��һ��������ʼ���ӿ�cashOrder/catorder   orderid:"+ orderid +"  localid"+localid+" url:"+url);
		HttpManager.requestGET(getActivity(), url,orderid,localid, this);		
	}

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.in_park_cars:
			setRadioChecked((Integer) v.getTag());
			break;
		case R.id.out_park_cars:
			setRadioChecked((Integer) v.getTag());
			break;
		default:
			break;
		}
	}

	@Override
	public boolean doSucess(String url, String object){
		DialogManager.getInstance().dissMissProgressDialog();
		if (url.contains(Constant.GET_CURRORDER)) {
			j=0;
			doGetOrdersResult(object);
		}else if(url.contains(Constant.ORDER_HISTORY)){
			doGetOrdersResult(object);
		}else if (url.contains(Constant.FREE_ORDER)){
			doFreeOrderResult(object);
		}
		return true;
	}

	@Override
	public boolean doSucess(String url, String object, String str) {
		// TODO Auto-generated method stub
//		HttpManager.UpLogs(getActivity(),"���̣�searchCarNumberOrder�ɹ�   Constant.QUERY_ORDER:"+ Constant.QUERY_ORDER+"  orderListState.getState()="+orderListState.getState() +" url:"+url+ "  object:"+object);
		FileUtil.writeSDFile("������������", "��searchCarNumberOrder�ɹ�   Constant.QUERY_ORDER:"+ Constant.QUERY_ORDER +"  orderListState.getState()="+orderListState.getState()+" url:"+url+ "  object:"+object);
		if(url.contains(Constant.QUERY_ORDER)){
			//��ǰ״̬Ϊ�ֶ�����
			Log.e("OrderListState", "��ǰ״̬Ϊ��"+orderListState.getState());
			if(orderListState.getState() == OrderListState.HAND_SEARCH_STATE){
				Log.e(TAG,  "�յ����복������״̬������"+Constant.QUERY_ORDER+"------------->"+ object);
				doHandSearchResult(object);
				//��ǰ״̬��ʶ����Զ����� 
				Log.e("OrderListState", "��ǰ״̬Ϊ��"+orderListState.getState());
			}else if(orderListState.getState() == OrderListState.AUTO_SEARCH_STATE){
				Log.e(TAG,  "���������Զ�������״̬������"+Constant.QUERY_ORDER+"------------->"+ object);
				doAutoSearchResult(object);
			}
		}
		return true;
	}

	@Override
	public boolean doSucess(String url, String object, String str1, String str2) {
		// TODO Auto-generated method stub
//		HttpManager.UpLogs(getActivity(),"���̣�cashOrder�ɹ�   Constant.CAT_ORDER:"+ Constant.CAT_ORDER +" url:"+url+ "  object:"+object);
		if(url.contains(Constant.CAT_ORDER)){
			FileUtil.writeSDFile("������������", "��cashOrder�ɹ�   Constant.CAT_ORDER:"+ Constant.CAT_ORDER +" url:"+url+ "  object:"+object);
			Log.e(TAG, "��ǰ�������飺"+Constant.CAT_ORDER+" ------------->"+ object);
			doCashOrderResult(object);
		}
		return true;
	}

	@Override
	public void timeout(String url) {
//		// TODO Auto-generated method stub
//		DialogManager.getInstance().dissMissProgressDialog();
//		if (url.contains(Constant.GET_CURRORDER)) {
//			Log.e(TAG,"��ʱ�ٻ�ȡ_��ǰ�����б�");
//			getOrderInPark(true);
//		}else if(url.contains(Constant.ORDER_HISTORY)){
//			Log.e(TAG, "��ʱ�ٻ�ȡ������ʷ������"+Constant.ORDER_HISTORY);
//			getHistoryOrder(true);
//		}else if (url.contains(Constant.FREE_ORDER)){
//			//doFreeOrderTimeOut();
//		}
	}

	@Override
	public void timeout(String url, String str) {
		// TODO Auto-generated method stub
		if(url.contains(Constant.QUERY_ORDER)){
			Log.e("OrderListState", "��ǰ״̬Ϊ��"+orderListState.getState());
			if(orderListState.getState() == OrderListState.HAND_SEARCH_STATE){
				Log.e(TAG,  "�յ����복������״̬������"+Constant.QUERY_ORDER);
				// str Ϊcarnumber
//				doHandSearchTimeOut(str);
			}else if(orderListState.getState() == OrderListState.AUTO_SEARCH_STATE){
				Log.e(TAG,  "���������Զ�������״̬������"+Constant.QUERY_ORDER);
				// str Ϊcarnumber
//				activity.doAutoSearchTimeOut(activity.resultBitmap,0, str);
			}
		}
	}

	@Override
	public void timeout(String url, String str, String str2) {
		// TODO Auto-generated method stub
		if(url.contains(Constant.CAT_ORDER)){
			Log.e(TAG, "��ʱ��ǰ�������飺"+Constant.CAT_ORDER);
			// strΪorderid str2Ϊlocalid
//			doCashOrderTimeOut(0,str,str2);
			FileUtil.writeSDFile("������������", "��catorder��ʱ��  ");
		}
	}

	private void doFreeOrderResult(String result){
		Log.e(TAG, "��Ѷ��������緵�ؽ����---------------��" + result);
		if (Constant.sOne.equals(result)){
			VoicePlayer.getInstance(activity).playVoice("�˳������");
			/* �������ڵ�բ  */
			activity.controlExitPole();
			orderListState.setState(OrderListState.CLEAR_FINISH_STATE);
			activity.sendLedShow("",null,"һ·˳��");
			activity.refreshListOrder();
		}
	}

	private void doCashOrderResult(String object) {
		Gson gson = new Gson();
		CarNumberOrder order = gson.fromJson(object, CarNumberOrder.class);
		if(!object.equals("-1")){
			if(itemOrder == null){
				activity.showToast("�˶����ѽ��㣡");
				return;
			}
			if (!itemOrder.getId().equals(order.getOrderid())) {
				activity.showToast("����ˢ�´��������ԣ�");
				return;
			}
			
			if(order != null){
				order.setLefttop(itemOrder.getLefttop());
				order.setRightbottom(itemOrder.getRightbottom());
				order.setHeight(itemOrder.getHeight());
				order.setWidth(itemOrder.getWidth());
				order.setCtype(itemOrder.getCtype());
				//���µ�ǰѡ����Ŀ�Ľ�����
				itemOrder.setTotal(order.getCollect());
				//�Ƿ���� ����ȯID�������ж���û��ʹ�ü���ȯ 3����ʱȯ 4��ȫ��ȯ
				if (order.getShopticketid() != null && Integer.valueOf(order.getShopticketid()) != -1) {
					itemOrder.setBefcollect(order.getBefcollect());
					itemOrder.setDistotal(order.getDistotal());
					itemOrder.setShopticketid(order.getShopticketid());
					itemOrder.setTickettime(order.getTickettime());
					itemOrder.setTickettype(order.getTickettype());
				}
				//�Ƿ�Ԥ֧��>0Ϊ��ʾ��Ԥ֧��
				itemOrder.setPrepay(order.getPrepay());
				itemOrder.setLimitday(order.getLimitday());
				itemOrder.setDuration(order.getDuration());
				Log.i(TAG, "��ǰ��������������Ӧ��"+order.toString());
				Log.i(TAG, "֮ǰ��������������Ӧ��"+itemOrder.toString());
				myListener.refreshCashView(order);
				myListener.refreshDetailView(order);
				myListener.refreshRecordView(order);
				FileUtil.writeSDFile("������������", "��doCashOrderResult  auto:"+ auto +" orders:"+order.toString());
				if(auto){
					System.out.println("��ȡ����ǰ����ѡ�����" + orders);
					activity.detailsFragment.selectClearOder(false);
					setAuto(false);
				}
			}
		}
	}

	/**
	 * �ֶ���ѯ�����Ľ������
	 */
	private void doHandSearchResult(String object) {
		// TODO Auto-generated method stub
		Gson gson = new Gson();
		CurrentOrder orders = gson.fromJson(object, CurrentOrder.class);
		if(orders != null){
			Log.e(TAG, "�ֶ���ѯ����Ӧ���ƺŶ���-->>"+orders.toString());
			ArrayList<AllOrder> orderinfos = orders.getInfo();
			//�·���ʾ��������
			if (orderinfos != null) {
				//��ȡ���������ص�����
				int count = StringUtils.stringToInt(orders.getCount());
				if (count == 0){
					adapter.removeOrders();
					clearOrthersFragment();
					itemOrder = null;
					ToastManager.getInstance().showToast(activity, "�޴˶���...", Toast.LENGTH_LONG);
					return;
				}else{
//					orderinfos = selectMonthUser(orderinfos);
					adapter.removeOrders();
					adapter.addOrders(orders.getInfo());
					if(orders.getInfo().get(0) != null){
						itemOrder = orders.getInfo().get(0);
						if(itemOrder == null){
							return;
						}
						adapter.setSelectedPosition(0);
						String orderid = orders.getInfo().get(0).getId();
						String localid = orders.getInfo().get(0).getLocalid();
						cashOrder(0,orderid,localid);
					}
				}
			}
		}
	}

	/**
	 * �Զ����������Ľ������
	 */
	@SuppressWarnings("null")
	private void doAutoSearchResult(String object) {
		// TODO Auto-generated method stub
		Gson gson = new Gson();
		CurrentOrder orders = gson.fromJson(object, CurrentOrder.class);
		Log.e(TAG, "��ȡ����ǰ����Ϊ" + object+"  orders:"+orders);
		FileUtil.writeSDFile("������������", "��dowutosearchResult  gson�������order��"+orders.toString());
		if(orders == null&&orders.getInfo() == null&&orders.getInfo().get(0) ==null){
			return;
		}
		Log.e(TAG, "orders.getinfo:" + orders.getInfo());
		//�¿��޶�����¼,���Զ�����
		if(Integer.valueOf(orders.getCount()) == 0&& orders.getInfo().get(0).getIsmonthuser().equals(Constant.sOne)){
			String limitday = orders.getInfo().get(0).getExptime();
			//�¿���������
			FileUtil.writeSDFile("������������", "�������¿��޶�����¼�Զ�����   "+limitday+"   carnumber"+orders.getInfo().get(0).getCarnumber());
			monthuserDeal(limitday,orders.getInfo().get(0).getCarnumber());
			return;
		}
		if (orders.getCount() != " "&&orders.getCount() != null) {
			//����б�����
			adapter.removeOrders();
			//�����ʾ����
			clearOrthersFragment();
			//���µ�ǰ����
			itemOrder = orders.getInfo().get(0);
			String isAuto = orders.getIsauto();
			//��ȡ���������ص�����
			int count = StringUtils.stringToInt(orders.getCount());
			Log.e(TAG,"count:"+count);
			FileUtil.writeSDFile("������������", "����ȡ���������ص�����  "+count+"  isauto= "+isAuto);
			if (count == 0){
				if(SharedPreferencesUtils.getParam(
						activity, "zld_config", "leaveset", Constant.sZero).equals(Constant.sOne)){
					activity.controlExitPole();
					getOrderInPark(true);
				}else{
					orderListState.setState(OrderListState.NO_ORDER_STATE);
					clearOrthersFragment();
					/**�޶�����¼�û���һ�������������*/
					activity.cashFragment.setFree(false);
					/** ����Ǿ�����,���Զ�̧��,�������������ɽ���,�������Զ�ˢ��*/
					int ntype = activity.exitFragment.exitCarBmpInfo.getNtype();
					boolean policePole = activity.isPolicePole(ntype);
					/** ����Ǿ������Զ�̧����,�Ͳ�����������Ϣ*/
					Log.e(TAG,"policePole:"+policePole);
					if(!policePole){
						VoicePlayer.getInstance(activity).playVoice(activity.getString(R.string.no_order_tip));
						ToastManager.getInstance().showToast(activity, "�޴˶���...", Toast.LENGTH_LONG);
					}
					activity.showFreeHideChargeFinish();
					return;
				}
			}
			/* ���ֻ��һ������ƥ���������Զ�������˶���  */
			else if ((count == 1&&isAuto == null)||(count == 1&&isAuto != null&&isAuto.equals(Constant.sOne))){
				System.out.println("��ȡ����ǰ�����ļ��ϵĳ���" + orders.getInfo().size());
				Log.e(TAG, orders.getInfo().toString());
				FileUtil.writeSDFile("������������", "��ֻ��һ������ƥ���˾��Զ�����  "+orders.getInfo().toString());
				adapter.addOrders(orders.getInfo());
				adapter.setSelectedPosition(0);
				/*���ж��Ƿ��Ǿ�����,����ǵĻ�,���ⵥ,return,���û�ȡ������ʾ*/
				int nType = 0;
				CarBitmapInfo exitCarInfo = activity.exitFragment.getExitCarInfo();
				if(exitCarInfo != null){
					Log.e(TAG,"��ȡ���ڵ���Ϣ��"+exitCarInfo.toString());
					nType = exitCarInfo.getNtype();
				}
				Log.e(TAG,"��ȡ���ڵ�nType��"+nType);
				/* ���������� */
				if (nType == Constant.LT_ARMPOL || nType == Constant.LT_ARMPOL2 ||
						nType == Constant.LT_ARMPOL2_ZONGDUI || nType == Constant.LT_ARMPOL_ZONGDUI || 
						nType == Constant.LT_ARMY || nType == Constant.LT_ARMY2 || nType == Constant.LT_POLICE){
					freeOrder();
					return;
				}
				/* �¿�����ʶ���,ƥ��������̴��� */
				if(orders.getInfo().get(0).getIsmonthuser().equals(Constant.sOne)){
					String collect = "�¿�	һ·˳��";
					String content = "�¿�	һ·˳��";
//					VoicePlayer.getInstance(activity).playVoice("�˳�Ϊ�¿��û�");
//					activity.sendLedShow(collect,content);
					//activity.detailsFragment.selectClearOder();
					//freeOrder();
					//setAuto(false);
					//return;
				}
				/* �˲�����Ҫ��ˢ������fragment��view */
				setAuto(true);
				cashOrder(0,itemOrder.getId(),itemOrder.getLocalid());
			}
			/* ����������ƥ�����ˣ�ֻ�г��б����ݣ����㶯�������շ�Ա   */			
			else{
				activity.showToast("���ֶ�ѡ����㶩��");
				adapter.addOrders(orders.getInfo());
				adapter.setSelectedPosition(0);
				AllOrder allOrder = orders.getInfo().get(0);
				if(allOrder!=null&&allOrder.getId()!=null){
					cashOrder(0,itemOrder.getId(),itemOrder.getLocalid());
				}
				VoicePlayer.getInstance(activity).playVoice("���ֶ�ѡ����㶩��");
				Log.e(TAG, SharedPreferencesUtils.getParam(
						activity, "zld_config", "leaveset", Constant.sZero));
				if(SharedPreferencesUtils.getParam(
						activity, "zld_config", "leaveset", Constant.sZero).equals(Constant.sOne)){
					activity.controlExitPole();
				}
			}
		}
	}

	@SuppressWarnings("null")
	private void monthuserDeal(String limitday,String carnumber) {
		Log.e(TAG,"�¿��Զ�����");
		String collect1 = "�¿�	һ·˳��";
		String collect2 = "һ·˳��";
		String content = "�¿�	һ·˳��";
		if(limitday != null&&!limitday.equals("-1")){
			Log.e(TAG, "�¿���Ч�ڣ�"+limitday);
			if (TimeTypeUtil.isMthUserExpire(limitday)){
				content = "�¿���Ч����"+ TimeTypeUtil.getFutureDate(Integer.parseInt(limitday), "MM��dd��") + "һ·˳��";
				activity.showToast(content);
			}
		}
		activity.controlExitPole();
		/*�޸�Ϊ�շ����״̬Ϊ���ö���Ϊ�¿�ʱ,����������Զ�ˢ��*/
		OrderListState.getInstance().
		setState(OrderListState.CLEAR_FINISH_STATE);
		/*��������״̬Ϊ�������Զ�ˢ��״̬,�����Զ�ˢ��֮��,��ȡ���б��һ��Ϊ�¿��û��Ļ�,�Ͳ�������*/
		activity.setDetailInCarState(ComeInCarState.AUTO_REFRESH_ORDER_LIST);
		/*ֱ��ˢ��,���õ����������*/
		activity.refreshListOrder();
		if (activity.getExitledinfo() != null) {
			if (Integer.parseInt(activity.getExitledinfo().getWidth()) > 64) {
				activity.sendLedShow(carnumber,collect1,content);
			}else {
				activity.sendLedShow(carnumber,collect2,content);
			}
		}

		/*�޶�����¼ʱ,����Ϊ�¿��Ļ�,û��orderid�����ϴ�ͼƬ*/
		/*uploadExitPhoto(currenOrder.getOrderid());*/
		activity.showToast("���㶩���ɹ�");
	}

	/**
	 * ��ȡ������ǰ�����Ľ������
	 * 
	 * @param object
	 */
	private void doGetOrdersResult(String object) {
//		lv_current_order.onRefreshComplete();
		if (object.length() > 30) {
			Gson gson = new Gson();
			orders = gson.fromJson(object, CurrentOrder.class);
			if (orders == null || orders.getInfo().size() == 0) {
				page--;
				return;
			}
			adapter.addOrders(orders.getInfo());
			Log.e(TAG, "�Ƿ���ʾ��һ��:"+isShowFirstItem+" ��ʾ�б�Order����"+orders.getInfo().get(0));
			Log.e(TAG, "OrderListState��״̬:"+orderListState.getState());
			itemOrder = orders.getInfo().get(0);
			if(isShowFirstItem&&orderListState.getState() == OrderListState.PARK_IN_STATE){
				cashOrder(0,itemOrder.getId(),itemOrder.getLocalid());
			}else if(isShowFirstItem&&OrderListState.getInstance().isParkOutState()){
				setOrderDetails();
			}
		}else{
			activity.showToast("û�е���Ķ�����¼��");
		}
	}

	public String getOrderid(){
		if(itemOrder != null){
			return itemOrder.getId();
		}else{
			return null;
		}
	}

	public interface OrderListListener{
		public void refreshDetailView(CarNumberOrder order);
		public void refreshCashView(CarNumberOrder order);
		public void refreshRecordView(CarNumberOrder order);
	}

	private class ListReceiver extends BroadcastReceiver{
		@Override
		public void onReceive(Context context, Intent intent) {
			String intentAction = intent.getAction();
			if (REFRESH_ITEM.equals(intentAction)){
				String carNumber = intent.getStringExtra("carNumber");
				adapter.changeItemContent(carNumber);
			}
		}
	}


	/**
	 * ��allOrderתΪCarNumberOrder,
	 * �ڻ�ȡ���볡�����б�������˶�������,�����ٴθ���orderidȥ��ȡ������
	 * @return
	 */
	private CarNumberOrder allOrderChangeCarNumber() {
		if(itemOrder == null){
			activity.showToast("�����µ��������");
			return null;
		}
		CarNumberOrder carNumberOrder = new CarNumberOrder();
		String begindate = "";
		if(itemOrder.getBtime() != null){
			//�Ƿ��Ǳ��ط�����
			if(!AppInfo.getInstance().getIsLocalServer(activity)){//�Ǳ��ط�������û��ƽ�屾�ػ��ĸ���
				boolean param = SharedPreferencesUtils.getParam(
						activity.getApplicationContext(), "nettype", "isLocal", false);
				Log.e("isLocal","OrderListFragment allOrderChangeCarNumber get isLocal "+param);
				if(param){
					begindate = itemOrder.getBtime();
				}else{
					begindate = TimeTypeUtil.getEasyStringTime(
							TimeTypeUtil.getLongTime(itemOrder.getBtime()));
				}
			}else{
				begindate = TimeTypeUtil.getEasyStringTime(
						TimeTypeUtil.getLongTime(itemOrder.getBtime()));
			}
		}
		if(itemOrder.getDuration() != null&&itemOrder.getDuration().substring(0, 2) != null){
			if(itemOrder.getDuration().substring(0, 2).equals("ͣ��")){
				carNumberOrder.setDuration(itemOrder.getDuration().substring(2));
			}else{
				carNumberOrder.setDuration(itemOrder.getDuration());
			}
		}else{
			carNumberOrder.setDuration("ͣ��ʱ��δ֪");
		}
		carNumberOrder.setBtime(begindate);
		carNumberOrder.setCar_type(itemOrder.getCar_type());
		carNumberOrder.setCarnumber(itemOrder.getCarnumber());
		carNumberOrder.setCollect(itemOrder.getTotal());

		carNumberOrder.setHeight(itemOrder.getHeight());
		carNumberOrder.setCtype(itemOrder.getCtype());
		carNumberOrder.setLefttop(itemOrder.getLefttop());
		carNumberOrder.setOrderid(itemOrder.getId());
		carNumberOrder.setLocalid(itemOrder.getLocalid());
		carNumberOrder.setPrepay(itemOrder.getPrepay());
		carNumberOrder.setRightbottom(itemOrder.getRightbottom());
		carNumberOrder.setTotal(itemOrder.getTotal());
		carNumberOrder.setWidth(itemOrder.getWidth());
		carNumberOrder.setUin(itemOrder.getUin());//-1δ�� �������ǰ�

		/*carNumberOrder.setDiscount(itemOrder.get);�Żݽ��*/
		/*carNumberOrder.setEtime(itemOrder.get);����ʱ��*/
		/*carNumberOrder.setHascard(itemOrder.get);�Ƿ��г���*/
		return carNumberOrder;
	}

	/**
	 * ���� ���ػ�ģʽ  ��ѯ���ݿ� ��ʾ
	 * @param type 0�ڳ� 1�볡
	 */
	public void doGetOrdersTimeOut(final int type) {
		new Thread(new Runnable() {

			@Override
			public void run() {
				// TODO Auto-generated method stub
//				ArrayList<AllOrder> localorders = getLocalOrderThread(type);
				Message msg = new Message();
				msg.what = Constant.LIST_REFRESH;
				msg.arg1 = type;
//				msg.obj = localorders;
				activity.handler.sendMessage(msg);
			}
		}).start();

	}

	public void localOrderShow(ArrayList<AllOrder> localorders,final int type) {
		if(localorders == null){
			return;
		}
		Log.e(TAG,"----------���ݿⷵ�ض���������"+localorders.size());
		adapter.addOrders(localorders);
		Log.e(TAG, "isShowFirstItem:"+isShowFirstItem+"��ǰ״̬Ϊ��"+orderListState.getState()
				+"type:"+type);
		if(isShowFirstItem&&orderListState.getState() == OrderListState.PARK_IN_STATE){
			if(type == 0){
				itemOrder = localorders.get(0);
				if(itemOrder != null){
					Log.e(TAG, "itemOrder0��"+itemOrder.toString());
					cashOrder(0,itemOrder.getId(),itemOrder.getLocalid());
				}
			}
		}else if(isShowFirstItem&&orderListState.isParkOutState()){
			if(type == 1){
				itemOrder = localorders.get(0);
				if(itemOrder != null){
					Log.e(TAG, "itemOrder1��"+itemOrder.toString());
					cashOrder(1,itemOrder.getId(),itemOrder.getLocalid());
				}
			}
		}
	}

//	private ArrayList<AllOrder> getLocalOrderThread(int type) {
//		LocalCurrentOrder currentOrder = getLocalOrderDBManager().getLocalCurrOrder(page,type);
//		if(currentOrder == null){
//			return null;
//		}
//		Log.e(TAG,"currentOrder:"+currentOrder.toString());
//		ArrayList<AllOrder> localorders = currentOrder.getInfo();
//		lv_current_order.postDelayed(new Runnable() {
//
//			@Override
//			public void run() {
//				lv_current_order.onRefreshComplete();
//			}
//		}, 3000);
//		if (localorders == null || localorders.size() == 0) {
//			if(page==1){
//				Message obtainMessage = activity.handler.obtainMessage(Constant.CLEAR_ORDER);
//				activity.handler.sendMessage(obtainMessage);
//			}
//			page--;
//			Looper.prepare();
//			activity.showToast("û���µĶ�����¼��");
//			Looper.loop();
//			return null;
//		}
//
//
//		localorders = selectMonthUser(localorders);
//		return localorders;
//	}

	/**
	 * ��ѯ�����Ƿ����¿�
	 * @return 
	 */
//	public ArrayList<AllOrder> selectMonthUser(ArrayList<AllOrder> localorders) {
//		if(localorders != null&&localorders.size()>0){
//			for(int i=0;i<localorders.size();i++){
//				String carnumber = localorders.get(i).getCarnumber();
//				int  isMonthCard = getLocalOrderDBManager().queryOrderCtype(carnumber);
//				if(isMonthCard == 5){
//					localorders.get(i).setIsmonthuser(Constant.sOne);
//				}else{
//					localorders.get(i).setIsmonthuser(Constant.sZero);
//				}
//			}
//		}
//		return localorders;
//	}



	/**
	 * ���ػ�,��ѯ���ݿ��Ƿ��ж���������
	 * @param orderid
	 */
//	private void doCashOrderTimeOut(int type,String orderid,String localid) {
//		CarNumberOrder order = getLocalOrderDBManager().queryLocalCarNumberOrderDetailsBycarNumber(type,orderid,localid);
//		if(order != null){
//			Log.e(TAG, "���ݿⶩ�����飺"+order);
//			localShowDetail(order);
//		}
//	}

	/**
	 * ������ʾ����
	 * @param loDBManager
	 * @param order
	 */
//	public void localShowDetail(CarNumberOrder order) {
//		if(order != null){
//			// ��ѯ�Ƿ�Ϊ����Ч���ڵ��¿�--�Ƿ����¿���
//			int  isMonthCard = getLocalOrderDBManager().queryOrderCtype(order.getCarnumber());
//			Log.e(TAG,"��ѯ�Ƿ����¿���"+isMonthCard);
//			if(isMonthCard == 5){
//				order.setIsmonthuser(Constant.sOne);
//			}else{
//				order.setIsmonthuser(Constant.sZero);
//			}
//			String collect = order.getTotal();
//			if(OrderListState.getInstance().isParkOutState()&&collect !=null&&!collect.equals("null")){
//
//			}else{
//				collect = localCashRefreshView(order);
//			}
//			order.setCollect(collect);
//			order.setTotal(collect);
//			itemOrder.setTotal(collect);
//			Log.i(TAG, "���ݿ��ѯ�Ķ������飺"+order.toString());
//			myListener.refreshCashView(order);
//			myListener.refreshDetailView(order);
//			myListener.refreshRecordView(order);
//		}
//	}

	/**
	 * ���ز�ѯ���ƺ���ʾ 
	 */
	public void localAddOrders(ArrayList<AllOrder> allOrders){
		if(allOrders !=null){
			adapter.removeOrders();
			adapter.addOrders(allOrders);
			if(allOrders.get(0) != null){
				itemOrder = allOrders.get(0);
				cashOrder(0,itemOrder.getId(),itemOrder.getLocalid());
			}
		}
	}
	/**
	 * ��ն���
	 */
	public void localClearOrder(){
		adapter.removeOrders();
		clearOrthersFragment();
	}

	/**
	 * ���ض���������ļ۸�
	 * @param order
	 */
//	private String localCashRefreshView(CarNumberOrder order) {
//		String collect = Constant.sZero;
//		if(order!=null){
//			Log.e(TAG,"����۸�"+order.toString());
//			//�¿����߾����۸�����Ϊ0
//			if(order.getIsmonthuser()==null||order.getCarnumber()==null||
//					order.getIsmonthuser().equals(Constant.sOne)||StringUtils.isPolice(order.getCarnumber())){
//				collect = Constant.sZero;
//			}else{
//				if(order.getCar_type()!=null&&!order.getCar_type().equals("null")){
////					Long orderStartTime = getLocalOrderDBManager().queryOrderTime("2",order.getOrderid());
//					collect = calculatePrice(Integer.parseInt(order.getCar_type()), order.getCarnumber(),orderStartTime);
//				}
//			}
//		}
//		return collect;
//	}
	/**
	 * ����۸�
	 * @param billingType
	 * @param carPlate
	 * @param currentTime
	 * @param loDBManager
	 * @return
	 */
//	@SuppressWarnings("rawtypes")
//	@TargetApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH_MR1)
//	@SuppressLint("NewApi")
//	private String calculatePrice(int billingType, String carPlate,Long orderStartTime ) {
//		Long currentTime = System.currentTimeMillis()/1000;
//		CountPrice countPrice = new CountPrice();
//		String comid = AppInfo.getInstance().getComid();
//		Long count = (long) loDBManager.queryCountByComid(""+billingType);
//		double minPriceUnit = loDBManager.queryMinPriceUnitByComid(comid);
//
//		Log.e(TAG,"=AppInfo.getInstance().isParkBilling():"+AppInfo.getInstance().isParkBilling());
//		if(AppInfo.getInstance().isParkBilling()){//���ִ�С��
//			if(billingType == 0){
//				billingType =1;
//			}else{
//				billingType = 2;
//			}
//		}else{//������
//			billingType = 0;
//		}
//		List<List<Map>> priceList = getLocalOrderDBManager().getPriceList(billingType,comid);
//		String total  = null;
//		Log.e(TAG,"�۸�"+priceList+"=="+comid+"=="+billingType);
//		if(priceList != null&&priceList.size()>0){
//			List<Map> list = null; 
//			List<Map> list2 = null;
//			if(priceList.size()>0){
//				list = priceList.get(0);
//			}
//			if(priceList.size()>=1){
//				list2 = priceList.get(1);
//			}
//			if(orderStartTime != null){
//				total = countPrice.getPrice(
//						count, list, list2,minPriceUnit,orderStartTime, currentTime, 
//						Long.parseLong(AppInfo.getInstance().getComid()), billingType);
//			}
//		}else{
//			total = "null";
//		}
//		Log.e(TAG,"���ؼ���۸�"+total);
//		return total;
//	}
}