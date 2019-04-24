function varargout = fig(varargin)
% FIG MATLAB code for fig.fig
%      FIG, by itself, creates a new FIG or raises the existing
%      singleton*.
%
%      H = FIG returns the handle to a new FIG or the handle to
%      the existing singleton*.
%
%      FIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIG.M with the given input arguments.
%
%      FIG('Property','Value',...) creates a new FIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fig

% Last Modified by GUIDE v2.5 13-Apr-2019 22:36:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fig_OpeningFcn, ...
                   'gui_OutputFcn',  @fig_OutputFcn, ...
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


% --- Executes just before fig is made visible.
function fig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fig (see VARARGIN)

% Choose default command line output for fig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fig_OutputFcn(hObject, eventdata, handles) 
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
%r jest wsp�czynnikiem rozrodczo�ci gatunku ofiar;
%r=1.2
%oznacza biomas� upolowanych ofiar,
%przy czym a jest wsp�czynnikiem skuteczno�ci polowa�, 
%czyli okre�la, jaka cze�� spotka� drapie�nik�w z ofiarami ko�czy si� jej upolowaniem
%aVP=0.6
% oznacza cze�� energii uzyskanej z polowania 
%przeznaczonej przez drapie�niki w procesie rozmna�ania 
%b=0.3
%s jest wsp�czynnikiem �miertelno�ci gatunku drapie�nik�w.
%s=0.8

r =str2double( get(handles.edit1,'String'));
aVP =str2double( get(handles.edit2,'String'));
b =str2double( get(handles.edit3,'String'));
s =str2double( get(handles.edit4,'String'));


[t,y]=ode45(@model,[1 100],[ 20 1],[],[r aVP b s],[]);
axes(handles.axes1);
datacursormode on
plot(t,y)
grid on
%legend({'populacja ofiar'; 'populacja drapie�nik�w'})
xlabel('Czas[s]')
ylabel('Liczebnosc populacji')


%rozwiazania stacjonarne Model Lotki-Volterry
A1 = 0;
A2=0;
A3 = s/aVP*b;
A4=r/aVP;

%rozwi�zania stacjonarne Model Lotki-Volterry z kryj�wkami dla ofiar
K=30;
A1_k = K + (s/(aVP*b));
A2_k = ((b*r)/s)*(K+(s/(aVP*b)));

%rozwi�zania stacjonarne dla ograniczonego �rodowiska
% V1=0;
% P1= r/aVP*(1-V1/K);
% V2=s/aVP*b;
% P2=0;
A1_o=0;
A2_o=0;
A3_o=K;
A4_o=0;
A5_o=s/aVP*b;
A6_o=(1-s/(aVP*b*K));

axes(handles.axes2);
X1=y(:,1);
Y1=y(:,2);
plot(X1,Y1)
xlabel('Populacja drapie�nik�w')
ylabel('Populacja ofiar')
hold on
plot(A1,A2,'r*')
plot(A3,A4,'r*')
hold off

[t,y]=ode45(@model,[1 100],[ 20 1],[],[r aVP b s],[30,-1]);
axes(handles.axes3);
plot(t,y)
grid on
%title('Model z kryj�wkami')
%legend({'populacja ofiar'; 'populacja drapie�nik�w'})
xlabel('Czas[s]')
ylabel('Liczebnosc populacji')

axes(handles.axes4);
X1=y(:,1);
Y1=y(:,2);
plot(X1,Y1)
xlabel('Populacja drapie�nik�w')
ylabel('Populacja ofiar')
hold on 
plot(A1_k,A2_k,'r*')
hold off


[t,y]=ode45(@model,[1 100],[ 20 1],[],[r aVP b s],[-1,30]);
axes(handles.axes5);
plot(t,y)
grid on
%title('Model z ograniczon� pojemno�ci�')
xlabel('Czas[s]')
ylabel('Liczebnosc populacji')

axes(handles.axes6);
X1=y(:,1);
Y1=y(:,2);
plot(X1,Y1)
xlabel('Populacja drapie�nik�w')
ylabel('Populacja ofiar')
hold on
plot(A1_o,A2_o,'r*')
plot(A3_o,A4_o,'r*')
plot(A5_o,A6_o,'r*')
hold off


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



function edit1_Callback(hObject, eventdata, handles)
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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x,z] = ginput(2)
axes(handles.axes7);
plot(x,z)
grid on
xlabel('Czas[s]')
ylabel('Liczebnosc populacji')
time = x(2:2,:)-x(1:1,:)
Y = sprintf('%.2f',time)

set(handles.czas, 'String',Y)
  




% --- Executes during object creation, after setting all properties.
function text6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes during object creation, after setting all properties.
function axes11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes(hObject)
imshow('lv.jpg')
% Hint: place code in OpeningFcn to populate axes11


% --- Executes during object creation, after setting all properties.
function axes10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes(hObject)
imshow('legenda.PNG')
% Hint: place code in OpeningFcn to populate axes10
