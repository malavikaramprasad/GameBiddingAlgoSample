function varargout = moddd(varargin)
% MODDD M-file for moddd.fig
%      MODDD, by itself, creates a new MODDD or raises the existing
%      singleton*.
%
%      H = MODDD returns the handle to a new MODDD or the handle to
%      the existing singleton*.
%
%      MODDD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODDD.M with the given input arguments.
%
%      MODDD('Property','Value',...) creates a new MODDD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before moddd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to moddd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help moddd

% Last Modified by GUIDE v2.5 15-Mar-2014 08:28:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @moddd_OpeningFcn, ...
                   'gui_OutputFcn',  @moddd_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before moddd is made visible.
function moddd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to moddd (see VARARGIN)

% Choose default command line output for moddd
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes moddd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = moddd_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
sheet = 1;
%xlRange1 = 'B2:E2';
maxgrade=100;
maxlossrate=0.1;
ql=2;
qd=2;
qj=2;
dthreshold=100;
jthreshold=50;
rcdrate=10;

x=(0.1).*rand(1,1)+0.5;
y=1-x;
w1=x/4;
w2=x/4;
w3=x/4;
w4=x/4;
w5=y/2;
w6=y/2;

wifival = xlsread('qosoff.xlsx',sheet,'B2:G2'); 
wimaxval = xlsread('qosoff.xlsx',sheet,'B3:G3'); 
lteval = xlsread('qosoff.xlsx',sheet,'B4:G4'); 
qoeval = xlsread('qoe.xlsx',sheet,'B2:B4'); 


tic
tpg1=(maxgrade*wifival(4))/rcdrate;
lossrate1=wifival(5)/(rcdrate*45);
lg1=maxgrade/(1+(lossrate1/maxlossrate)^ql);
dg1=maxgrade/(1+(wifival(1)/dthreshold)^qd);
jg1=maxgrade/(1+(wifival(2)/jthreshold)^qj);
vg1=wifival(3);
pg1=maxgrade/(2.71828)^(wifival(6)*2);
qos1=w5*tpg1 + w1*lg1 + w2*dg1 + w3*jg1 + w6*vg1 + w4*pg1;
qds1=qos1+(0.775*log(qoeval(1))+11.268);
set(handles.edit1,'String',qds1);



tpg2=(maxgrade*wimaxval(4))/rcdrate;
lossrate2=wimaxval(5)/(rcdrate*45);
lg2=maxgrade/(1+(lossrate2/maxlossrate)^ql);
dg2=maxgrade/(1+(wimaxval(1)/dthreshold)^qd);
jg2=maxgrade/(1+(wimaxval(2)/jthreshold)^qj);
vg2=wimaxval(3);
pg2=maxgrade/(2.71828)^(wimaxval(6)*2);
qos2=w5*tpg2 + w1*lg2 + w2*dg2 + w3*jg2 + w6*vg2 + w4*pg2;
qds2 = qos2 + (0.775*log(qoeval(2))+11.268);
set(handles.edit2,'String',qds2);


tpg3=(maxgrade*lteval(4))/rcdrate;
lossrate3=lteval(5)/(rcdrate*45);
lg3=maxgrade/(1+(lossrate3/maxlossrate)^ql);
dg3=maxgrade/(1+(lteval(1)/dthreshold)^qd);
jg3=maxgrade/(1+(lteval(2)/jthreshold)^qj);
vg3=lteval(3);
pg3=maxgrade/(2.71828)^(lteval(6)*2);
qos3=w5*tpg3 + w1*lg3 + w2*dg3 + w3*jg3 + w6*vg3 + w4*pg3;
qds3 = qos3 + (0.775*log(qoeval(3))+11.268);
set(handles.edit3,'String',qds3);


a=[qds1 qds2 qds3];
aa=[qds1 qds2 qds3];
c=[0.2 0.4 0.6];
for i=1:3
    for j=i+1:3
        if(a(i)>a(j))
            tempq=a(i);
            tempc=c(i);
            a(i)=a(j);
            c(i)=c(j);
            a(j)=tempq;
            c(j)=tempc;
        end
    end
end
x31=abs(a(3)-a(1));
x32=abs(a(3)-a(2));

if(x32<3 && x31>=3)
   if(c(2)<c(3))
       qds=a(2);
   end
   if(c(2)>c(3))
       qds=a(3);
   end
end 
if(x31<3 && x32>=3)
    if(c(3)<c(1))
       qds=a(3);
   end
   if(c(3)>c(1))
       qds=a(1);
   end
end
if(x31<3 && x32<3)
    if(c(1)<c(2))
        qds=a(1);
    end
    if(c(1)>c(2))
        qds=a(2);
    end
end
if(x31>=3 && x32>=3)
    qds=a(3);
end

for i=1:3
    if(qds==aa(i))
        z=i;
    end
end
if(z==1)
    nw='WiFi';
end
if(z==2)
    nw='WiMAX';
end
if(z==3)
    nw='LTE';
end
   
set(handles.edit13,'String',nw);

t1=toc;
xlswrite('time.xlsx',t1,1,'A1');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5


x=(0.1).*rand(1,1)+0.5;
y=1-x;
w1=x/4;
w2=x/4;
w3=x/4;
w4=x/4;
w5=y/2;
w6=y/2;

wifival = xlsread('qosoff.xlsx',sheet,'B2:G2'); 
wimaxval = xlsread('qosoff.xlsx',sheet,'B3:G3'); 
lteval = xlsread('qosoff.xlsx',sheet,'B4:G4'); 
qoeval = xlsread('qoe.xlsx',sheet,'C2:C4'); 


tic
tpg4=(maxgrade*wifival(4))/rcdrate;
lossrate4=wifival(5)/(rcdrate*45);
lg4=maxgrade/(1+(lossrate4/maxlossrate)^ql);
dg4=maxgrade/(1+(wifival(1)/dthreshold)^qd);
jg4=maxgrade/(1+(wifival(2)/jthreshold)^qj);
vg4=wifival(3);
pg4=maxgrade/(2.71828)^(wifival(6)*2);
qos4=w5*tpg4 + w1*lg4 + w2*dg4 + w3*jg4 + w6*vg4 + w4*pg4;
qds4 = qos4 + (0.775*log(qoeval(1))+11.268);   
set(handles.edit4,'String',qds4);


tpg5=(maxgrade*wimaxval(4))/rcdrate;
lossrate5=wimaxval(5)/(rcdrate*45);
lg5=maxgrade/(1+(lossrate5/maxlossrate)^ql);
dg5=maxgrade/(1+(wimaxval(1)/dthreshold)^qd);
jg5=maxgrade/(1+(wimaxval(2)/jthreshold)^qj);
vg5=wimaxval(3);
pg5=maxgrade/(2.71828)^(wimaxval(6)*2);
qos5=w5*tpg5 + w1*lg5 + w2*dg5 + w3*jg5 + w6*vg5 + w4*pg5;
qds5 = qos5 + (0.775*log(qoeval(2))+11.268);
set(handles.edit5,'String',qds5);


tpg6=(maxgrade*lteval(4))/rcdrate;
lossrate6=lteval(5)/(rcdrate*45);
lg6=maxgrade/(1+(lossrate6/maxlossrate)^ql);
dg6=maxgrade/(1+(lteval(1)/dthreshold)^qd);
jg6=maxgrade/(1+(lteval(2)/jthreshold)^qj);
vg6=lteval(3);
pg6=maxgrade/(2.71828)^(lteval(6)*2);
qos6=w5*tpg6 + w1*lg6 + w2*dg6 + w3*jg6 + w6*vg6 + w4*pg6;
qds6 = qos6 +(0.775*log(qoeval(3))+11.268);
set(handles.edit6,'String',qds6);

a=[qds4 qds5 qds6];
aa=[qds4 qds5 qds6];
c=[0.2 0.4 0.6];
for i=1:3
    for j=i+1:3
        if(a(i)>a(j))
            tempq=a(i);
            tempc=c(i);
            a(i)=a(j);
            c(i)=c(j);
            a(j)=tempq;
            c(j)=tempc;
        end
    end
end
x31=abs(a(3)-a(1));
x32=abs(a(3)-a(2));

if(x32<3 && x31>=3)
   if(c(2)<c(3))
       qds=a(2);
   end
   if(c(2)>c(3))
       qds=a(3);
   end
end 
if(x31<3 && x32>=3)
    if(c(3)<c(1))
       qds=a(3);
   end
   if(c(3)>c(1))
       qds=a(1);
   end
end
if(x31<3 && x32<3)
    if(c(1)<c(2))
        qds=a(1);
    end
    if(c(1)>c(2))
        qds=a(2);
    end
end
if(x31>=3 && x32>=3)
    qds=a(3);
end

for i=1:3
    if(qds==aa(i))
        z=i;
    end
end
if(z==1)
    nw='WiFi';
end
if(z==2)
    nw='WiMAX';
end
if(z==3)
    nw='LTE';
end
   
set(handles.edit14,'String',nw);


t2=toc;
xlswrite('time.xlsx',t2,1,'B1');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55



x=(0.1).*rand(1,1)+0.5;
y=1-x;
w1=x/4;
w2=x/4;
w3=x/4;
w4=x/4;
w5=y/2;
w6=y/2;

wifival = xlsread('qosoff.xlsx',sheet,'B2:G2'); 
wimaxval = xlsread('qosoff.xlsx',sheet,'B3:G3'); 
lteval = xlsread('qosoff.xlsx',sheet,'B4:G4'); 
qoeval = xlsread('qoe.xlsx',sheet,'D2:D4');

tic
tpg7=(maxgrade*wifival(4))/rcdrate;
lossrate7=wifival(5)/(rcdrate*45);
lg7=maxgrade/(1+(lossrate7/maxlossrate)^ql);
dg7=maxgrade/(1+(wifival(1)/dthreshold)^qd);
jg7=maxgrade/(1+(wifival(2)/jthreshold)^qj);
vg7=wifival(3);
pg7=maxgrade/(2.71828)^(wifival(6)*2);
qos7=w5*tpg7 + w1*lg7 + w2*dg7 + w3*jg7 + w6*vg7 + w4*pg7;
qds7 = qos7 + (0.775*log(qoeval(1))+11.268);
set(handles.edit7,'String',qds7);


tpg8=(maxgrade*wimaxval(4))/rcdrate;
lossrate8=wimaxval(5)/(rcdrate*45);
lg8=maxgrade/(1+(lossrate8/maxlossrate)^ql);
dg8=maxgrade/(1+(wimaxval(1)/dthreshold)^qd);
jg8=maxgrade/(1+(wimaxval(2)/jthreshold)^qj);
vg8=wimaxval(3);
pg8=maxgrade/(2.71828)^(wimaxval(6)*2);
qos8=w5*tpg8 + w1*lg8 + w2*dg8 + w3*jg8 + w6*vg8 + w4*pg8;
qds8 = qos8 +(0.775*log(qoeval(2))+11.268);
set(handles.edit8,'String',qds8);


tpg9=(maxgrade*lteval(4))/rcdrate;
lossrate9=lteval(5)/(rcdrate*45);
lg9=maxgrade/(1+(lossrate9/maxlossrate)^ql);
dg9=maxgrade/(1+(lteval(1)/dthreshold)^qd);
jg9=maxgrade/(1+(lteval(2)/jthreshold)^qj);
vg9=lteval(3);
pg9=maxgrade/(2.71828)^(lteval(6)*2);
qos9=w5*tpg9 + w1*lg9 + w2*dg9 + w3*jg9 + w6*vg9 + w4*pg9;
qds9 = qos9 + (0.775*log(qoeval(3))+11.268);
set(handles.edit9,'String',qds9);


a=[qds7 qds8 qds9];
aa=[qds7 qds8 qds9];
c=[0.2 0.4 0.6];
for i=1:3
    for j=i+1:3
        if(a(i)>a(j))
            tempq=a(i);
            tempc=c(i);
            a(i)=a(j);
            c(i)=c(j);
            a(j)=tempq;
            c(j)=tempc;
        end
    end
end
x31=abs(a(3)-a(1));
x32=abs(a(3)-a(2));

if(x32<3 && x31>=3)
   if(c(2)<c(3))
       qds=a(2);
   end
   if(c(2)>c(3))
       qds=a(3);
   end
end 
if(x31<3 && x32>=3)
    if(c(3)<c(1))
       qds=a(3);
   end
   if(c(3)>c(1))
       qds=a(1);
   end
end
if(x31<3 && x32<3)
    if(c(1)<c(2))
        qds=a(1);
    end
    if(c(1)>c(2))
        qds=a(2);
    end
end
if(x31>=3 && x32>=3)
    qds=a(3);
end

for i=1:3
    if(qds==aa(i))
        z=i;
    end
end
if(z==1)
    nw='WiFi';
end
if(z==2)
    nw='WiMAX';
end
if(z==3)
    nw='LTE';
end
   
set(handles.edit15,'String',nw);



t3=toc;
xlswrite('time.xlsx',t3,1,'C1');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5


x=(0.1).*rand(1,1)+0.5;
y=1-x;
w1=x/4;
w2=x/4;
w3=x/4;
w4=x/4;
w5=y/2;
w6=y/2;


wifival = xlsread('qosoff.xlsx',sheet,'B2:G2'); 
wimaxval = xlsread('qosoff.xlsx',sheet,'B3:G3'); 
lteval = xlsread('qosoff.xlsx',sheet,'B4:G4'); 
qoeval = xlsread('qoe.xlsx',sheet,'E2:E4');

tic
tpg10=(maxgrade*wifival(4))/rcdrate;
lossrate10=wifival(5)/(rcdrate*45);
lg10=maxgrade/(1+(lossrate10/maxlossrate)^ql);
dg10=maxgrade/(1+(wifival(1)/dthreshold)^qd);
jg10=maxgrade/(1+(wifival(2)/jthreshold)^qj);
vg10=maxgrade/(1+wifival(3));
pg10=maxgrade/(2.71828)^(wifival(6)*2);
qos10=w5*tpg10 + w1*lg10 + w2*dg10 + w3*jg10 + w6*vg10 + w4*pg10;
qds10 = qos10 + (0.775*log(qoeval(1))+11.268);
set(handles.edit10,'String',qds10);


tpg11=(maxgrade*wimaxval(4))/rcdrate;
lossrate11=wimaxval(5)/(rcdrate*45);
lg11=maxgrade/(1+(lossrate11/maxlossrate)^ql);
dg11=maxgrade/(1+(wimaxval(1)/dthreshold)^qd);
jg11=maxgrade/(1+(wimaxval(2)/jthreshold)^qj);
vg11=maxgrade/(1+wimaxval(3));
pg11=maxgrade/(2.71828)^(wimaxval(6)*2);
qos11=w5*tpg11 + w1*lg11 + w2*dg11 + w3*jg11 + w6*vg11 + w4*pg11;
qds11 = qos11 +(0.775*log(qoeval(2))+11.268);
set(handles.edit11,'String',qds11);


tpg12=(maxgrade*lteval(4))/rcdrate;
lossrate12=lteval(5)/(rcdrate*45);
lg12=maxgrade/(1+(lossrate12/maxlossrate)^ql);
dg12=maxgrade/(1+(lteval(1)/dthreshold)^qd);
jg12=maxgrade/(1+(lteval(2)/jthreshold)^qj);
vg12=maxgrade/(1+lteval(3));
pg12=maxgrade/(2.71828)^(lteval(6)*2);
qos12=w5*tpg12 + w1*lg12 + w2*dg12 + w3*jg12 + w6*vg12 + w4*pg12;
qds12 = qos12 + (0.775*log(qoeval(3))+11.268);
set(handles.edit12,'String',qds12);


a=[qds10 qds11 qds12];
aa=[qds10 qds11 qds12];
c=[0.2 0.4 0.6];
for i=1:3
    for j=i+1:3
        if(a(i)>a(j))
            tempq=a(i);
            tempc=c(i);
            a(i)=a(j);
            c(i)=c(j);
            a(j)=tempq;
            c(j)=tempc;
        end
    end
end
x31=abs(a(3)-a(1));
x32=abs(a(3)-a(2));

if(x32<3 && x31>=3)
   if(c(2)<c(3))
       qds=a(2);
   end
   if(c(2)>c(3))
       qds=a(3);
   end
end 
if(x31<3 && x32>=3)
    if(c(3)<c(1))
       qds=a(3);
   end
   if(c(3)>c(1))
       qds=a(1);
   end
end
if(x31<3 && x32<3)
    if(c(1)<c(2))
        qds=a(1);
    end
    if(c(1)>c(2))
        qds=a(2);
    end
end
if(x31>=3 && x32>=3)
    qds=a(3);
end

for i=1:3
    if(qds==aa(i))
        z=i;
    end
end
if(z==1)
    nw='WiFi';
end
if(z==2)
    nw='WiMAX';
end
if(z==3)
    nw='LTE';
end
   
set(handles.edit16,'String',nw);


t4=toc;
xlswrite('time.xlsx',t4,1,'D1');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

sheet=1;
xlswrite('graph.xlsx',qds1,sheet,'A1');
xlswrite('graph.xlsx',qds2,sheet,'B1');
xlswrite('graph.xlsx',qds3,sheet,'C1');
xlswrite('graph.xlsx',qds4,sheet,'A2');
xlswrite('graph.xlsx',qds5,sheet,'B2');
xlswrite('graph.xlsx',qds6,sheet,'C2');
xlswrite('graph.xlsx',qds7,sheet,'A3');
xlswrite('graph.xlsx',qds8,sheet,'B3');
xlswrite('graph.xlsx',qds9,sheet,'C3');
xlswrite('graph.xlsx',qds10,sheet,'A4');
xlswrite('graph.xlsx',qds11,sheet,'B4');
xlswrite('graph.xlsx',qds12,sheet,'C4');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5555

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

guidata(hObject,handles);

function edit1_Callback(~, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(~, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, ~, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, ~, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit27 as text
%        str2double(get(hObject,'String')) returns contents of edit27 as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1,'string','');
set(handles.edit2,'string','');
set(handles.edit3,'string','');
set(handles.edit4,'string','');
set(handles.edit5,'string','');
set(handles.edit6,'string','');
set(handles.edit7,'string','');
set(handles.edit8,'string','');
set(handles.edit9,'string','');
set(handles.edit10,'string','');
set(handles.edit11,'string','');
set(handles.edit12,'string','');
set(handles.edit13,'string','');
set(handles.edit14,'string','');
set(handles.edit15,'string','');
set(handles.edit16,'string','');