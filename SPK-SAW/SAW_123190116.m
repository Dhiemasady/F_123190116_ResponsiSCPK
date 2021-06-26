function varargout = SAW_123190116(varargin)
% SAW_123190116 MATLAB code for SAW_123190116.fig
%      SAW_123190116, by itself, creates a new SAW_123190116 or raises the existing
%      singleton*.
%
%      H = SAW_123190116 returns the handle to a new SAW_123190116 or the handle to
%      the existing singleton*.
%
%      SAW_123190116('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAW_123190116.M with the given input arguments.
%
%      SAW_123190116('Property','Value',...) creates a new SAW_123190116 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAW_123190116_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAW_123190116_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAW_123190116

% Last Modified by GUIDE v2.5 26-Jun-2021 10:58:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAW_123190116_OpeningFcn, ...
                   'gui_OutputFcn',  @SAW_123190116_OutputFcn, ...
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


% --- Executes just before SAW_123190116 is made visible.
function SAW_123190116_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAW_123190116 (see VARARGIN)

% Choose default command line output for SAW_123190116
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAW_123190116 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAW_123190116_OutputFcn(hObject, eventdata, handles) 
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
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = {'NO','HARGA','LB','LT','KT','KM','GRS'};
%pilih data dari .xlsx untuk kolom NO, HARGA, LB, LT, KT, KM, GRS
data = readmatrix('DATA RUMAH.xlsx', opts);
set(handles.uitable1,'data',data); %menampilkan data ke uitable1

x=data(:,2:7); %matriks x yang berisi data kolom 2-7
no = data(:,1); %matriks no yang berisi data kolom 1 (No Rumah)
k=[0,1,1,1,1,1]; %atribut tiap-tiap kriteria
w=[0.3,0.2,0.23,0.1,0.07,0.1]; %Nilai bobot tiap kriteria 
[m n]=size (x); 
R=zeros (m,n); 
Y=zeros (m,n);
for j=1:n,
    if k(j)==1,
        R(:,j)=x(:,j)./max(x(:,j));
    else
        R(:,j)=min(x(:,j))./x(:,j);
    end;
end;
for i=1:m,
    V(i)= sum(w.*R(i,:))
    hasil(i) = [V(i)]; %menyimpan hasil perhitungan ke variabel hasil
end;

r = reshape(hasil,[1010,1]); %menukar baris dan kolom
a = [no r]; %matriks a = gabungan matriks no dan r
p = sortrows(a, 2, 'descend') 
%mengurutkan matriks a menggunakan kolom 2 secara descending

set(handles.uitable2, 'data', p(1:20,:)); 
%menampilkan data ke uitable2 hanya untuk baris 1-20(peringkat)



% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
