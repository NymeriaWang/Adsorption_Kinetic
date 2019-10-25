%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Designed by Nana Sun, 26th, Oct. 2019, ZJU     %
%    Made by Nymeria Wang, 26th, Oct. 2019, KTH     %    
%                                                   %
%    Updating in     %    
%                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






function varargout = Adsorption_Kinetic(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Adsorption_Kinetic_OpeningFcn, ...
                   'gui_OutputFcn',  @Adsorption_Kinetic_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function Adsorption_Kinetic_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = Adsorption_Kinetic_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)

    

function edit1_CreateFcn(hObject, eventdata, handles)

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in pushbutton1.


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global A B t C_C0 Kd Qmax Voidpore C0 Dp Dab Mw u p P dp Vad V0 Kf load_tag save_tag % A, B: Coefficient matrices
format long g
msgbox('It may take time for running. Close this window after you see the figure in the figure area and take the result.');

load_tag = 0;
if load_tag == 0
    t = str2num(get(handles.edit1,'String'));
    C_C0 = str2num(get(handles.edit8,'String'));
    Kd = str2num(get(handles.edit2,'String'));
    Qmax = str2num(get(handles.edit4,'String'));
    C0 = str2num(get(handles.edit3,'String'));
    Mw = str2num(get(handles.edit11,'String'));
    V0= str2num(get(handles.edit14,'String'));
    Vad= str2num(get(handles.edit13,'String'));
    dp= str2num(get(handles.edit6,'String'));
    Voidpore= str2num(get(handles.edit5,'String'));
    Dab= str2num(get(handles.edit12,'String'));
    Dp= str2num(get(handles.edit15,'String'));
    u= str2num(get(handles.edit7,'String'));
    p= str2num(get(handles.edit9,'String'));
    P= str2num(get(handles.edit10,'String'));
    save_tag = 1
else
    set(handles.edit1,'String', t);
    set(handles.edit8,'String', C_C0);
    set(handles.edit2,'String', Kd);
    set(handles.edit4,'String',Qmax);
    set(handles.edit3,'String', C0);
    set(handles.edit11,'String', Mw);
    set(handles.edit14,'String', V0);
    set(handles.edit13,'String', Vad);
    set(handles.edit6,'String', dp);
    set(handles.edit5,'String', Voidpore);
    set(handles.edit12,'String', Dab);
    set(handles.edit15,'String', Dp);
    set(handles.edit7,'String', u);
    set(handles.edit9,'String', p);
    set(handles.edit10,'String', P);

    save_tag = 1;
end
x= t;
X= C_C0;

Kf=2*Dab/dp+(0.31*(u/p/Dab)^(-2/3))*((P-p)*u*9.8/p/p)^(1/3)          % Kf: Solid-liquid film transfer coefficient (m s-1)
set(handles.edit17, 'string', Kf);
A=[-1.553628E+01	2.751189E+01	-2.293872E+01	2.138316E+01	-2.041895E+01	1.959798E+01	-1.878022E+01	1.790641E+01	-1.694376E+01	1.586776E+01	-1.465351E+01	1.326864E+01	-1.166235E+01	9.740052E+00	-7.275310E+00	2.933206E+00;
-3.537219E+00	-7.804578E+00	1.874532E+01	-1.365341E+01	1.192224E+01	-1.095353E+01	1.023923E+01	-9.613291E+00	9.004219E+00	-8.373543E+00	7.694749E+00	-6.943213E+00	6.087728E+00	-5.075924E+00	3.787708E+00	-1.526480E+00;
9.161764E-01	-5.823195E+00	-5.243893E+00	1.617368E+01	-1.081596E+01	8.976440E+00	-7.968466E+00	7.258493E+00	-6.669074E+00	6.122476E+00	-5.576178E+00	5.000182E+00	-4.365067E+00	3.629015E+00	-2.703312E+00	1.088683E+00;
-3.852700E-01	1.913343E+00	-7.296117E+00	-3.976363E+00	1.517707E+01	-9.569858E+00	7.632404E+00	-6.577159E+00	5.847221E+00	-5.255605E+00	4.719047E+00	-4.190410E+00	3.633687E+00	-3.007578E+00	2.234494E+00	-8.989084E-01;
2.055982E-01	-9.336892E-01	2.726725E+00	-8.481691E+00	-3.226596E+00	1.488741E+01	-8.986747E+00	6.938912E+00	-5.824725E+00	5.059008E+00	-4.443632E+00	3.888354E+00	-3.338655E+00	2.745643E+00	-2.032168E+00	8.162526E-01;
-1.273888E-01	5.537733E-01	-1.460873E+00	3.452478E+00	-9.610543E+00	-2.736163E+00	1.504614E+01	-8.776194E+00	6.592106E+00	-5.401500E+00	4.582532E+00	-3.922244E+00	3.319570E+00	-2.704892E+00	1.991302E+00	-7.981031E-01;
8.778231E-02	-3.722484E-01	9.325519E-01	-1.980066E+00	4.171828E+00	-1.081994E+01	-2.394656E+00	1.557715E+01	-8.831424E+00	6.472332E+00	-5.179836E+00	4.283337E+00	-3.548246E+00	2.852943E+00	-2.084364E+00	8.328531E-01;
-6.570144E-02	2.743441E-01	-6.668047E-01	1.339387E+00	-2.528476E+00	4.953882E+00	-1.222702E+01	-2.146586E+00	1.648884E+01	-9.120132E+00	6.529935E+00	-5.097030E+00	4.083683E+00	-3.218922E+00	2.325907E+00	-9.253081E-01;
5.265483E-02	-2.176371E-01	5.189055E-01	-1.008549E+00	1.797760E+00	-3.151831E+00	5.871771E+00	-1.396712E+01	-1.961968E+00	1.785665E+01	-9.655549E+00	6.750123E+00	-5.113157E+00	3.907010E+00	-2.776515E+00	1.097454E+00;
-4.484521E-02	1.840673E-01	-4.332306E-01	8.243782E-01	-1.419924E+00	2.348471E+00	-3.913072E+00	7.024732E+00	-1.623677E+01	-1.821919E+00	1.983724E+01	-1.048998E+01	7.132871E+00	-5.169528E+00	3.577427E+00	-1.399930E+00;
4.041418E-02	-1.650499E-01	3.850352E-01	-7.223544E-01	1.217153E+00	-1.944462E+00	3.056401E+00	-4.908957E+00	8.569022E+00	-1.936181E+01	-1.715722E+00	2.272853E+01	-1.172778E+01	7.664525E+00	-5.063887E+00	1.948941E+00;
-3.858159E-02	1.570528E-01	-3.640663E-01	6.763203E-01	-1.122942E+00	1.754677E+00	-2.664552E+00	4.039542E+00	-6.315299E+00	1.079362E+01	-2.396050E+01	-1.635757E+00	2.711093E+01	-1.353361E+01	8.142556E+00	-3.039398E+00;
3.926624E-02	-1.593754E-01	3.678901E-01	-6.789159E-01	1.116188E+00	-1.719218E+00	2.555409E+00	-3.747015E+00	5.538339E+00	-8.496935E+00	1.431330E+01	-3.138590E+01	-1.576067E+00	3.423054E+01	-1.597716E+01	5.579631E+00;
-4.337865E-02	1.758964E-01	-4.047737E-01	7.435775E-01	-1.214654E+00	1.853709E+00	-2.718661E+00	3.907919E+00	-5.599547E+00	8.148519E+00	-1.237791E+01	2.073251E+01	-4.529818E+01	-1.536389E+00	4.707473E+01	-1.344335E+01;
5.525865E-02	-2.236809E-01	5.139590E-01	-9.417981E-01	1.532613E+00	-2.326410E+00	3.386294E+00	-4.814318E+00	6.784099E+00	-9.613208E+00	1.394144E+01	-2.126401E+01	3.604159E+01	-8.024285E+01	-1.509666E+00	5.868072E+01;
-1.341271E-01	5.429962E-01	-1.246570E+00	2.281605E+00	-3.707278E+00	5.615342E+00	-8.148351E+00	1.153371E+01	-1.614878E+01	2.265584E+01	-3.231517E+01	4.780439E+01	-7.580864E+01	1.380198E+02	-3.534443E+02	2.624996E+02];

B=[-3.016729E+02	3.847182E+02	-1.221875E+02	6.209976E+01	-3.813190E+01	2.599027E+01	-1.893363E+01	1.443880E+01	-1.137481E+01	9.167428E+00	-7.495158E+00	6.160655E+00	-5.027739E+00	3.981421E+00	-2.876343E+00	1.143464E+00;
9.846504E+01	-3.519654E+02	3.210719E+02	-9.962230E+01	5.115230E+01	-3.194657E+01	2.214597E+01	-1.637517E+01	1.263992E+01	-1.004529E+01	8.132309E+00	-6.637777E+00	5.390617E+00	-4.254741E+00	3.067736E+00	-1.218560E+00;
-1.445874E+01	1.484454E+02	-3.772577E+02	3.059888E+02	-9.214964E+01	4.696114E+01	-2.935791E+01	2.043389E+01	-1.517753E+01	1.175486E+01	-9.348017E+00	7.535223E+00	-6.066440E+00	4.760424E+00	-3.420452E+00	1.356730E+00;
4.371629E+00	-2.740127E+01	1.820352E+02	-4.068870E+02	3.102286E+02	-9.126057E+01	4.605101E+01	-2.868625E+01	1.994830E+01	-1.480960E+01	1.144687E+01	-9.048304E+00	7.187448E+00	-5.590207E+00	3.995530E+00	-1.581415E+00;
-1.848768E+00	9.689902E+00	-3.775568E+01	2.136587E+02	-4.467356E+02	3.279697E+02	-9.480789E+01	4.741365E+01	-2.939561E+01	2.037769E+01	-1.507241E+01	1.156954E+01	-9.010628E+00	6.918560E+00	-4.907607E+00	1.936419E+00;
9.592259E-01	-4.606766E+00	1.464693E+01	-4.784589E+01	2.496648E+02	-5.015749E+02	3.591913E+02	-1.025107E+02	5.088793E+01	-3.139679E+01	2.166440E+01	-1.591035E+01	1.203922E+01	-9.075023E+00	6.368589E+00	-2.501993E+00;
-5.742102E-01	2.624166E+00	-7.524072E+00	1.983893E+01	-5.930368E+01	2.951476E+02	-5.780416E+02	4.070837E+02	-1.151270E+02	5.682343E+01	-3.489136E+01	2.391809E+01	-1.733866E+01	1.272590E+01	-8.795725E+00	3.434479E+00;
3.833738E-01	-1.698796E+00	4.585078E+00	-1.082017E+01	2.596747E+01	-7.375329E+01	3.564385E+02	-6.868305E+02	4.784354E+02	-1.345047E+02	6.610480E+01	-4.037611E+01	2.737905E+01	-1.931293E+01	1.305668E+01	-5.053818E+00;
-2.799754E-01	1.215596E+00	-3.156949E+00	6.974637E+00	-1.492267E+01	3.393571E+01	-9.343250E+01	4.434478E+02	-8.465075E+02	5.860235E+02	-1.642651E+02	8.047998E+01	-4.878278E+01	3.233630E+01	-2.114572E+01	8.079675E+00;
2.209236E-01	-9.457307E-01	2.393656E+00	-5.069419E+00	1.012804E+01	-2.049960E+01	4.515097E+01	-1.220619E+02	5.737650E+02	-1.091696E+03	7.545300E+02	-2.115155E+02	1.033119E+02	-6.160847E+01	3.820357E+01	-1.430787E+01;
-1.872065E-01	7.938819E-01	-1.973515E+00	4.061929E+00	-7.765293E+00	1.466219E+01	-2.873617E+01	6.217907E+01	-1.666979E+02	7.820679E+02	-1.493163E+03	1.035732E+03	-2.913140E+02	1.412583E+02	-7.984225E+01	2.892420E+01;
1.703799E-01	-7.166814E-01	1.759801E+00	-3.552209E+00	6.593825E+00	-1.191099E+01	2.178878E+01	-4.200642E+01	9.032602E+01	-2.424535E+02	1.145391E+03	-2.214703E+03	1.552892E+03	-4.393328E+02	2.059259E+02	-7.017209E+01;
-1.666071E-01	6.987770E-01	-1.700181E+00	3.385654E+00	-6.163231E+00	1.081881E+01	-1.896072E+01	3.419630E+01	-6.573994E+01	1.422050E+02	-3.868764E+02	1.864911E+03	-3.710539E+03	2.660614E+03	-7.505518E+02	2.238690E+02;
1.796036E-01	-7.488909E-01	1.813349E+00	-3.580193E+00	6.432850E+00	-1.108442E+01	1.891661E+01	-3.278871E+01	5.922144E+01	-1.152341E+02	2.549017E+02	-7.168526E+02	3.614865E+03	-7.670214E+03	5.738774E+03	-1.144602E+03;
-2.237344E-01	9.337559E-01	-2.251236E+00	4.421368E+00	-7.889713E+00	1.345773E+01	-2.262553E+01	3.837180E+01	-6.706641E+01	1.237826E+02	-2.496235E+02	5.822242E+02	-1.767130E+03	9.945110E+03	-2.543468E+04	1.684319E+04;
-7.028910E+01	2.844469E+02	-6.527902E+02	1.194134E+03	-1.938651E+03	2.932942E+03	-4.248950E+03	6.000055E+03	-8.371483E+03	1.168149E+04	-1.651438E+04	2.403784E+04	-3.683050E+04	6.084405E+04	-8.446038E+04	4.611247E+04];

y0=zeros(15,1); y0(16) = 1;
tn=4*Dp*x/dp/dp;
[t,Y] = ode45(@CPD,[tn(1) tn(end)],y0);             % ode45 is a function to solve non-stiff differential equations by using Runge-Kutta method, medium order method.
T=t*dp*dp/4/Dp;






try 
    axes(handles.axes1);


    plot(x,X,'o',T,Y(:,16),'r-'),legend('Experimental','Model')
    xlabel('Time(s)'),ylabel('C/Co')
    T(1:10:end);
    Y(1:10:end,16);
    %new_axes=copyobj(handles.axes1,new_f_handle)

    grid on;

catch ErrorInfo
    axes(handles.axes1);
    image = imread('Nana.jpg');
    imshow(image);
    h=errordlg('Adsorption Kinetic got some problems, there is a high probability that the input data was wrong. Restart Adsorption Kinetic again.','Error');

end



function edit2_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2num(get(hObject,'String')) returns contents of edit5 as a double


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



% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2num(get(hObject,'String')) returns contents of edit7 as a double


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
%        str2num(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)



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



function edit10_Callback(hObject, eventdata, handles)



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
%        str2num(get(hObject,'String')) returns contents of edit11 as a double


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
%        str2num(get(hObject,'String')) returns contents of edit12 as a double


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
%        str2num(get(hObject,'String')) returns contents of edit13 as a double


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
%        str2num(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
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
%        str2num(get(hObject,'String')) returns contents of edit15 as a double


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



function dydx=CPD(t,y)
global A B Kd Qmax Voidpore C0 CD Dp dp Vad V0 Kf CPD_16

AC=A(16,1)*y(1)+A(16,2)*y(2)+A(16,3)*y(3)+A(16,4)*y(4)+A(16,5)*y(5)+A(16,6)*y(6)+A(16,7)*y(7)+A(16,8)*y(8)+A(16,9)*y(9)+A(16,10)*y(10)+A(16,11)*y(11)+A(16,12)*y(12)+A(16,13)*y(13)+A(16,14)*y(14)+A(16,15)*y(15);
CPD_16=(y(16)-AC*2*Voidpore*Dp/Kf/dp)/(1+2*Voidpore*Dp*A(16,16)/Kf/dp);

 dy(1)=(B(1,1)*y(1)+B(1,2)*y(2)+B(1,3)*y(3)+B(1,4)*y(4)+B(1,5)*y(5)+B(1,6)*y(6)+B(1,7)*y(7)+B(1,8)*y(8)+B(1,9)*y(9)+B(1,10)*y(10)+B(1,11)*y(11)+B(1,12)*y(12)+B(1,13)*y(13)+B(1,14)*y(14)+B(1,15)*y(15)+B(1,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(1))/(Kd+C0*y(1)));
 dy(2)=(B(2,1)*y(1)+B(2,2)*y(2)+B(2,3)*y(3)+B(2,4)*y(4)+B(2,5)*y(5)+B(2,6)*y(6)+B(2,7)*y(7)+B(2,8)*y(8)+B(2,9)*y(9)+B(2,10)*y(10)+B(2,11)*y(11)+B(2,12)*y(12)+B(2,13)*y(13)+B(2,14)*y(14)+B(2,15)*y(15)+B(2,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(2))/(Kd+C0*y(2)));
 dy(3)=(B(3,1)*y(1)+B(3,2)*y(2)+B(3,3)*y(3)+B(3,4)*y(4)+B(3,5)*y(5)+B(3,6)*y(6)+B(3,7)*y(7)+B(3,8)*y(8)+B(3,9)*y(9)+B(3,10)*y(10)+B(3,11)*y(11)+B(3,12)*y(12)+B(3,13)*y(13)+B(3,14)*y(14)+B(3,15)*y(15)+B(3,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(3))/(Kd+C0*y(3)));
 dy(4)=(B(4,1)*y(1)+B(4,2)*y(2)+B(4,3)*y(3)+B(4,4)*y(4)+B(4,5)*y(5)+B(4,6)*y(6)+B(4,7)*y(7)+B(4,8)*y(8)+B(4,9)*y(9)+B(4,10)*y(10)+B(4,11)*y(11)+B(4,12)*y(12)+B(4,13)*y(13)+B(4,14)*y(14)+B(4,15)*y(15)+B(4,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(4))/(Kd+C0*y(4)));
 dy(5)=(B(5,1)*y(1)+B(5,2)*y(2)+B(5,3)*y(3)+B(5,4)*y(4)+B(5,5)*y(5)+B(5,6)*y(6)+B(5,7)*y(7)+B(5,8)*y(8)+B(5,9)*y(9)+B(5,10)*y(10)+B(5,11)*y(11)+B(5,12)*y(12)+B(5,13)*y(13)+B(5,14)*y(14)+B(5,15)*y(15)+B(5,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(5))/(Kd+C0*y(5)));
 dy(6)=(B(6,1)*y(1)+B(6,2)*y(2)+B(6,3)*y(3)+B(6,4)*y(4)+B(6,5)*y(5)+B(6,6)*y(6)+B(6,7)*y(7)+B(6,8)*y(8)+B(6,9)*y(9)+B(6,10)*y(10)+B(6,11)*y(11)+B(6,12)*y(12)+B(6,13)*y(13)+B(6,14)*y(14)+B(6,15)*y(15)+B(6,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(6))/(Kd+C0*y(6)));
 dy(7)=(B(7,1)*y(1)+B(7,2)*y(2)+B(7,3)*y(3)+B(7,4)*y(4)+B(7,5)*y(5)+B(7,6)*y(6)+B(7,7)*y(7)+B(7,8)*y(8)+B(7,9)*y(9)+B(7,10)*y(10)+B(7,11)*y(11)+B(7,12)*y(12)+B(7,13)*y(13)+B(7,14)*y(14)+B(7,15)*y(15)+B(7,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(7))/(Kd+C0*y(7)));
 dy(8)=(B(8,1)*y(1)+B(8,2)*y(2)+B(8,3)*y(3)+B(8,4)*y(4)+B(8,5)*y(5)+B(8,6)*y(6)+B(8,7)*y(7)+B(8,8)*y(8)+B(8,9)*y(9)+B(8,10)*y(10)+B(8,11)*y(11)+B(8,12)*y(12)+B(8,13)*y(13)+B(8,14)*y(14)+B(8,15)*y(15)+B(8,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(8))/(Kd+C0*y(8)));
 dy(9)=(B(9,1)*y(1)+B(9,2)*y(2)+B(9,3)*y(3)+B(9,4)*y(4)+B(9,5)*y(5)+B(9,6)*y(6)+B(9,7)*y(7)+B(9,8)*y(8)+B(9,9)*y(9)+B(9,10)*y(10)+B(9,11)*y(11)+B(9,12)*y(12)+B(9,13)*y(13)+B(9,14)*y(14)+B(9,15)*y(15)+B(9,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(9))/(Kd+C0*y(9)));
 dy(10)=(B(10,1)*y(1)+B(10,2)*y(2)+B(10,3)*y(3)+B(10,4)*y(4)+B(10,5)*y(5)+B(10,6)*y(6)+B(10,7)*y(7)+B(10,8)*y(8)+B(10,9)*y(9)+B(10,10)*y(10)+B(10,11)*y(11)+B(10,12)*y(12)+B(10,13)*y(13)+B(10,14)*y(14)+B(10,15)*y(15)+B(10,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(10))/(Kd+C0*y(10)));
 dy(11)=(B(11,1)*y(1)+B(11,2)*y(2)+B(11,3)*y(3)+B(11,4)*y(4)+B(11,5)*y(5)+B(11,6)*y(6)+B(11,7)*y(7)+B(11,8)*y(8)+B(11,9)*y(9)+B(11,10)*y(10)+B(11,11)*y(11)+B(11,12)*y(12)+B(11,13)*y(13)+B(11,14)*y(14)+B(11,15)*y(15)+B(11,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(11))/(Kd+C0*y(11)));
 dy(12)=(B(12,1)*y(1)+B(12,2)*y(2)+B(12,3)*y(3)+B(12,4)*y(4)+B(12,5)*y(5)+B(12,6)*y(6)+B(12,7)*y(7)+B(12,8)*y(8)+B(12,9)*y(9)+B(12,10)*y(10)+B(12,11)*y(11)+B(12,12)*y(12)+B(12,13)*y(13)+B(12,14)*y(14)+B(12,15)*y(15)+B(12,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(12))/(Kd+C0*y(12)));
 dy(13)=(B(13,1)*y(1)+B(13,2)*y(2)+B(13,3)*y(3)+B(13,4)*y(4)+B(13,5)*y(5)+B(13,6)*y(6)+B(13,7)*y(7)+B(13,8)*y(8)+B(13,9)*y(9)+B(13,10)*y(10)+B(13,11)*y(11)+B(13,12)*y(12)+B(13,13)*y(13)+B(13,14)*y(14)+B(13,15)*y(15)+B(13,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(13))/(Kd+C0*y(13)));
 dy(14)=(B(14,1)*y(1)+B(14,2)*y(2)+B(14,3)*y(3)+B(14,4)*y(4)+B(14,5)*y(5)+B(14,6)*y(6)+B(14,7)*y(7)+B(14,8)*y(8)+B(14,9)*y(9)+B(14,10)*y(10)+B(14,11)*y(11)+B(14,12)*y(12)+B(14,13)*y(13)+B(14,14)*y(14)+B(14,15)*y(15)+B(14,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(14))/(Kd+C0*y(14)));
 dy(15)=(B(15,1)*y(1)+B(15,2)*y(2)+B(15,3)*y(3)+B(15,4)*y(4)+B(15,5)*y(5)+B(15,6)*y(6)+B(15,7)*y(7)+B(15,8)*y(8)+B(15,9)*y(9)+B(15,10)*y(10)+B(15,11)*y(11)+B(15,12)*y(12)+B(15,13)*y(13)+B(15,14)*y(14)+B(15,15)*y(15)+B(15,16)*CPD_16)/(1+Kd*Qmax/Voidpore/(Kd+C0*y(15))/(Kd+C0*y(15)));
 dy(16)=-(3*dp*Kf*Vad/2/Dp/V0)*(y(16)-CPD_16);
 dydx=[dy(1);dy(2);dy(3);dy(4);dy(5);dy(6);dy(7);dy(8);dy(9);dy(10);dy(11);dy(12);dy(13);dy(14);dy(15);dy(16)];



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2num(get(hObject,'String')) returns contents of edit17 as a double


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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
    global A B t C_C0 Kd Qmax Voidpore C0 Dp Dab Mw u p P dp Vad V0 Kf load_tag save_tag 
    
    load_tag = 1;
    [filename,filepath] = uigetfile('.mat','Load your data');
    file =[filepath '\' filename];
    load(file);
    
    set(handles.edit1,'String', num2str(t));
    set(handles.edit8,'String', num2str(C_C0));
    set(handles.edit2,'String', Kd);
    set(handles.edit4,'String',Qmax);
    set(handles.edit3,'String', C0);
    set(handles.edit11,'String', Mw);
    set(handles.edit14,'String', V0);
    set(handles.edit13,'String', Vad);
    set(handles.edit6,'String', dp);
    set(handles.edit5,'String', Voidpore);
    set(handles.edit12,'String', Dab);
    set(handles.edit15,'String', Dp);
    set(handles.edit7,'String', u);
    set(handles.edit9,'String', p);
    set(handles.edit10,'String', P);
    set(handles.edit17,'String', Kf);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
    global A B t C_C0 Kd Qmax Voidpore C0 Dp Dab Mw u p P dp Vad V0 Kf load_tag save_tag
    save_tag = 1;            %This tag is for the future use. In some cases, the number of the input data might not be enough to be saved.
    if save_tag == 1    
        t = str2num(get(handles.edit1,'String'));
        C_C0 = str2num(get(handles.edit8,'String'));
        Kd = str2num(get(handles.edit2,'String'));
        Qmax = str2num(get(handles.edit4,'String'));
        C0 = str2num(get(handles.edit3,'String'));
        Mw = str2num(get(handles.edit11,'String'));
        V0= str2num(get(handles.edit14,'String'));
        Vad= str2num(get(handles.edit13,'String'));
        dp= str2num(get(handles.edit6,'String'));
        Voidpore= str2num(get(handles.edit5,'String'));
        Dab= str2num(get(handles.edit12,'String'));
        Dp= str2num(get(handles.edit15,'String'));
        u= str2num(get(handles.edit7,'String'));
        p= str2num(get(handles.edit9,'String'));
        P= str2num(get(handles.edit10,'String'));
        Kf = str2num(get(handles.edit17,'String'));
        folder_name = string(uigetdir())
        savename = string(inputdlg('Name the file','Save data'))
        name = strcat(folder_name, '\', savename)
        save(name, 't', 'C_C0', 'Kd', 'Qmax', 'Voidpore', 'C0', 'Dp', 'dp', 'Vad', 'V0', 'Dab', 'Mw', 'u', 'p', 'P', 'Kf');
        
        %save_tag = 0;
        
    elseif save_tag == 0
        
        h=errordlg('Workspace did not find any data can be saved','Error');
    end



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
msgbox('Coming soon');


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
    msgbox('For further questions, feel free to contact 21828074@zju.edu.cn and cc to huanyu@kth.se', 'Help');
