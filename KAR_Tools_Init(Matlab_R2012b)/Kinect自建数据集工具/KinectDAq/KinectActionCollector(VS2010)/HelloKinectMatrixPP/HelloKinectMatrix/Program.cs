using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Kinect;
using System.IO;
namespace HelloKinectMatrix
{
    class Program
    {


        static Skeleton[] skeletons;
        static void Main(string[] args)
        {
            if (KinectSensor.KinectSensors.Count > 0)
            {
                //设置控制台前景色
                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine("Welcome to the Kinect Matrix...");

                //默认选择第一个Kinect传感器
                KinectSensor _kinect = KinectSensor.KinectSensors[0];

                //启用深度摄像头默认选项，注册事件，启动Kinect传感器
                _kinect.SkeletonStream.Enable();//启用骨骼追踪摄像机
                _kinect.DepthStream.Enable();
                //_kinect.DepthFrameReady += new EventHandler<DepthImageFrameReadyEventArgs>(_kinect_DepthFrameReady);
                _kinect.SkeletonFrameReady += new EventHandler<SkeletonFrameReadyEventArgs>(_kinect_SkeletonFrameReady);
                _kinect.Start();

                //按回车键退出
                while (Console.ReadKey().Key != ConsoleKey.Enter)
                {
                }

                //关闭Kinect传感器
                _kinect.Stop();
                Console.WriteLine("Exit the Kinect Matrix...");
            }
            else
            {
                Console.WriteLine("Please check the kinect sensor");
            }
        }



        //static void _kinect_DepthFrameReady(object sender, DepthImageFrameReadyEventArgs e)
        //{
        //    //获取Kinect摄像头深度数据，并将深度值打印到控制台上
        //    using (DepthImageFrame depthFrame = e.OpenDepthImageFrame())
        //    {
        //        if (depthFrame != null)
        //        {
        //            short[] depthPixelData = new short[depthFrame.PixelDataLength];
        //            depthFrame.CopyPixelDataTo(depthPixelData);

        //            foreach (short pixel in depthPixelData)
        //            {
        //                Console.Write(pixel);

        //            }
        //        }
        //    }
        //}
        static void _kinect_SkeletonFrameReady(object sender, SkeletonFrameReadyEventArgs e)
        {
            bool isSkeletionDataReady = false;
            using (SkeletonFrame skeletonFrame = e.OpenSkeletonFrame())
            {
                if (skeletonFrame != null)
                {
                    skeletons = new Skeleton[skeletonFrame.SkeletonArrayLength];
                    skeletonFrame.CopySkeletonDataTo(skeletons);
                    isSkeletionDataReady = true;

                }
            }
            if (isSkeletionDataReady)
            {
                Skeleton curretskeleton = (
                    from s in skeletons
                    where
                    s.TrackingState == SkeletonTrackingState.Tracked
                    select s).FirstOrDefault();
                 // int kk = 1;
                if (curretskeleton != null)
                {
                  //  foreach (Joint item in curretskeleton.Joints)
                  //  {
                  //      writebone(item.JointType + " " + item.Position.X + " " + item.Position.Y + " " + item.Position.Z);
                  //     Console.WriteLine(item.JointType + " " + item.Position.X + " " + item.Position.Y + " " + item.Position.Z);
                  //  }
                    // Joint head = curretskeleton.Joints[JointType.Head];
                    // Console.WriteLine(head.Position);
                    // writebone(head.Position.X+" "+head.Position.Y+" "+head.Position.Z);
                    Joint HipCenter = curretskeleton.Joints[JointType.HipCenter];
                    Joint Spine = curretskeleton.Joints[JointType.Spine];
                    Joint ShoulderCenter = curretskeleton.Joints[JointType.ShoulderCenter];
                    Joint Head = curretskeleton.Joints[JointType.Head];

                    Joint ShoulderLeft = curretskeleton.Joints[JointType.ShoulderLeft];
                    Joint ElbowLeft = curretskeleton.Joints[JointType.ElbowLeft];
                    Joint WristLeft = curretskeleton.Joints[JointType.WristLeft];
                    Joint HandLeft = curretskeleton.Joints[JointType.HandLeft];

                    Joint ShoulderRight = curretskeleton.Joints[JointType.ShoulderRight];
                    Joint ElbowRight = curretskeleton.Joints[JointType.ElbowRight];
                    Joint WristRight = curretskeleton.Joints[JointType.WristRight];
                    Joint HandRight = curretskeleton.Joints[JointType.HandRight];

                    Joint HipLeft = curretskeleton.Joints[JointType.HipLeft];
                    Joint KneeLeft = curretskeleton.Joints[JointType.KneeLeft];
                    Joint AnkleLeft = curretskeleton.Joints[JointType.AnkleLeft];
                    Joint FootLeft = curretskeleton.Joints[JointType.FootLeft];

                    Joint HipRight = curretskeleton.Joints[JointType.HipRight];
                    Joint KneeRight = curretskeleton.Joints[JointType.KneeRight];
                    Joint AnkleRight = curretskeleton.Joints[JointType.AnkleRight];
                    Joint FootRight = curretskeleton.Joints[JointType.FootRight];  

                    //Console.WriteLine(HipCenter.Position);
                    writebone("1 " + HipCenter.Position.X + " " + HipCenter.Position.Y + " " + HipCenter.Position.Z + " 1 " + Spine.Position.X + " " + Spine.Position.Y + " " + Spine.Position.Z + " 1 " + ShoulderCenter.Position.X + " " + ShoulderCenter.Position.Y + " " + ShoulderCenter.Position.Z + " 1 " + Head.Position.X + " " + Head.Position.Y + " " + Head.Position.Z + " 1 " + ShoulderLeft.Position.X + " " + ShoulderLeft.Position.Y + " " + ShoulderLeft.Position.Z + " 1 " + ElbowLeft.Position.X + " " + ElbowLeft.Position.Y + " " + ElbowLeft.Position.Z + " 1 " + WristLeft.Position.X + " " + WristLeft.Position.Y + " " + WristLeft.Position.Z + " 1 " + HandLeft.Position.X + " " + HandLeft.Position.Y + " " + HandLeft.Position.Z + " 1 " + ShoulderRight.Position.X + " " + ShoulderRight.Position.Y + " " + ShoulderRight.Position.Z + " 1 " + ElbowRight.Position.X + " " + ElbowRight.Position.Y + " " + ElbowRight.Position.Z + " 1 " + WristRight.Position.X + " " + WristRight.Position.Y + " " + WristRight.Position.Z + " 1 " + HandRight.Position.X + " " + HandRight.Position.Y + " " + HandRight.Position.Z + " 1 " + HipLeft.Position.X + " " + HipLeft.Position.Y + " " + HipLeft.Position.Z + " 1 " + KneeLeft.Position.X + " " + KneeLeft.Position.Y + " " + KneeLeft.Position.Z + " 1 " + AnkleLeft.Position.X + " " + AnkleLeft.Position.Y + " " + AnkleLeft.Position.Z + " 1 " + FootLeft.Position.X + " " + FootLeft.Position.Y + " " + FootLeft.Position.Z + " 1 " + HipRight.Position.X + " " + HipRight.Position.Y + " " + HipRight.Position.Z + " 1 " + KneeRight.Position.X + " " + KneeRight.Position.Y + " " + KneeRight.Position.Z + " 1 " + AnkleRight.Position.X + " " + AnkleRight.Position.Y + " " + AnkleRight.Position.Z + " 1 " + FootRight.Position.X + " " + FootRight.Position.Y + " " + FootRight.Position.Z + " 1");
                    Console.WriteLine("1 " + HipCenter.Position.X + " " + HipCenter.Position.Y + " " + HipCenter.Position.Z + " 1 " + Spine.Position.X + " " + Spine.Position.Y + " " + Spine.Position.Z + " 1 " + ShoulderCenter.Position.X + " " + ShoulderCenter.Position.Y + " " + ShoulderCenter.Position.Z + " 1 " + Head.Position.X + " " + Head.Position.Y + " " + Head.Position.Z + " 1 " + ShoulderLeft.Position.X + " " + ShoulderLeft.Position.Y + " " + ShoulderLeft.Position.Z + " 1 " + ElbowLeft.Position.X + " " + ElbowLeft.Position.Y + " " + ElbowLeft.Position.Z + " 1 " + WristLeft.Position.X + " " + WristLeft.Position.Y + " " + WristLeft.Position.Z + " 1 " + HandLeft.Position.X + " " + HandLeft.Position.Y + " " + HandLeft.Position.Z + " 1 " + ShoulderRight.Position.X + " " + ShoulderRight.Position.Y + " " + ShoulderRight.Position.Z + " 1 " + ElbowRight.Position.X + " " + ElbowRight.Position.Y + " " + ElbowRight.Position.Z + " 1 " + WristRight.Position.X + " " + WristRight.Position.Y + " " + WristRight.Position.Z + " 1 " + HandRight.Position.X + " " + HandRight.Position.Y + " " + HandRight.Position.Z + " 1 " + HipLeft.Position.X + " " + HipLeft.Position.Y + " " + HipLeft.Position.Z + " 1 " + KneeLeft.Position.X + " " + KneeLeft.Position.Y + " " + KneeLeft.Position.Z + " 1 " + AnkleLeft.Position.X + " " + AnkleLeft.Position.Y + " " + AnkleLeft.Position.Z + " 1 " + FootLeft.Position.X + " " + FootLeft.Position.Y + " " + FootLeft.Position.Z + " 1 " + HipRight.Position.X + " " + HipRight.Position.Y + " " + HipRight.Position.Z + " 1 " + KneeRight.Position.X + " " + KneeRight.Position.Y + " " + KneeRight.Position.Z + " 1 " + AnkleRight.Position.X + " " + AnkleRight.Position.Y + " " + AnkleRight.Position.Z + " 1 " + FootRight.Position.X + " " + FootRight.Position.Y + " " + FootRight.Position.Z + " 1");
                        
                        // kk = kk + 1;
                }
            }
        }
        static void writebone(string str)
        {
            if (!File.Exists("C:\\Users\\admin\\Desktop\\sj\\a01.txt"))
            {
                FileInfo myfile = new FileInfo("C:\\Users\\admin\\Desktop\\sj\\a01.txt");
                FileStream fs = myfile.Create();
                fs.Close();
            }
           // StreamWriter sw = File.AppendText("C:\\Users\\Administrator\\Desktop\\data.txt");
            StreamWriter sw = File.AppendText("C:\\Users\\admin\\Desktop\\sj\\a01.txt");
            
            sw.WriteLine(str);
            sw.Flush();
            sw.Close();

        }

    }
}
