function data = load_data(path)
    
    %load �õ���Ϊ1*1��struct
    data = load(path);
    data= data.after_mfcc;
end