within Modelica_Magnetic_Transformers.Examples;
model Rectifier6pulse "6-pulse rectifier with 1 transformer"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage V=100*sqrt(2/3)
  "Amplitude of star-voltage";
  parameter Modelica.SIunits.Frequency f=50 "Frequency";
  parameter Modelica.SIunits.Resistance RL=0.4 "Load resistance";
  parameter Modelica.SIunits.Capacitance C=0.005 "Total DC-capacitance";
  parameter Modelica.SIunits.Voltage VC0=sqrt(3)*V
  "Initial voltage of capacitance";
  Modelica.Electrical.MultiPhase.Sources.SineVoltage source(
    m=m,
    V=fill(V, m),
    freqHz=fill(f, m)) annotation (Placement(transformation(
        origin={-90,-10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.MultiPhase.Basic.Star starAC(m=m) annotation (
      Placement(transformation(
        origin={-90,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundAC annotation (Placement(
        transformation(extent={{-100,-80},{-80,-60}}, rotation=0)));
  Modelica.Electrical.MultiPhase.Sensors.CurrentSensor currentSensor(m=m)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}},
          rotation=0)));
  Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode1(
    m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m),
    Vknee=fill(0, m)) annotation (Placement(transformation(
        origin={-20,60},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Electrical.MultiPhase.Basic.Star star1(m=m) annotation (
      Placement(transformation(
        origin={0,70},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode2(
    m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m),
    Vknee=fill(0, m)) annotation (Placement(transformation(
        origin={-20,20},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Electrical.MultiPhase.Basic.Star star2(m=m) annotation (
      Placement(transformation(extent={{-10,0},{10,20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor load(R=RL) annotation (
      Placement(transformation(
        origin={50,0},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor cDC1(C=2*C, v(start=VC0/2))
    annotation (Placement(transformation(
        origin={70,20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor cDC2(C=2*C, v(start=VC0/2))
    annotation (Placement(transformation(
        origin={70,-20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundDC annotation (Placement(
        transformation(extent={{80,-20},{100,0}}, rotation=0)));
  parameter Modelica.Electrical.Machines.Utilities.TransformerData transformerData1(
    C1=Modelica.Utilities.Strings.substring(
            transformer1.VectorGroup,
            1,
            1),
    C2=Modelica.Utilities.Strings.substring(
            transformer1.VectorGroup,
            2,
            2),
    f=50,
    V1=100,
    V2=100,
    SNominal=30E3,
    v_sc=0.05,
    P_sc=300) annotation (Placement(transformation(extent={{-60,60},{-40,80}},
          rotation=0)));
BaseTransformers.ThreePhase.Dy.Dy01 transformer1(
  n=transformerData1.n,
  R1=transformerData1.R1,
  L1sigma=transformerData1.L1sigma,
  R2=transformerData1.R2,
  L2sigma=transformerData1.L2sigma,
  alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
  alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
  T1Ref=293.15,
  T2Ref=293.15,
  T1Operational=293.15,
  T2Operational=293.15)
                 annotation (Placement(transformation(extent={{-50,30},{-30,
          50}}, rotation=0)));

initial equation
  cDC1.v = VC0/2;
  cDC2.v = VC0/2;
  transformer1.transformer.i2[1:2] = zeros(2);

equation
  connect(cDC1.n, cDC2.p)
    annotation (Line(points={{70,10},{70,-10}}, color={0,0,255}));
  connect(cDC1.n, groundDC.p)
    annotation (Line(points={{70,10},{70,0},{90,0}}, color={0,0,255}));
  connect(starAC.plug_p, source.plug_n)
    annotation (Line(points={{-90,-30},{-90,-20}}, color={0,0,255}));
  connect(diode1.plug_n, star1.plug_p)
    annotation (Line(points={{-20,70},{-10,70}}, color={0,0,255}));
  connect(diode2.plug_p, star2.plug_p)
    annotation (Line(points={{-20,10},{-10,10}}, color={0,0,255}));
  connect(diode2.plug_n, diode1.plug_p)
    annotation (Line(points={{-20,30},{-20,50}}, color={0,0,255}));
  connect(starAC.pin_n, groundAC.p)
    annotation (Line(points={{-90,-50},{-90,-60}}, color={0,0,255}));
  connect(source.plug_p, currentSensor.plug_p)
    annotation (Line(points={{-90,0},{-85,0},{-80,0}}, color={0,0,255}));
  connect(load.p, cDC1.p)
    annotation (Line(points={{50,10},{50,30},{70,30}}, color={0,0,255}));
  connect(load.n, cDC2.n) annotation (Line(points={{50,-10},{50,-30},{70,
          -30}}, color={0,0,255}));
  connect(star1.pin_n, cDC1.p)
    annotation (Line(points={{10,70},{70,70},{70,30}}, color={0,0,255}));
  connect(star2.pin_n, cDC2.n) annotation (Line(points={{10,10},{20,10},{
          20,-70},{70,-70},{70,-30}}, color={0,0,255}));
  connect(transformer1.plug1, currentSensor.plug_n) annotation (Line(
      points={{-50,40},{-60,40},{-60,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(transformer1.plug2, diode1.plug_p) annotation (Line(
      points={{-30,40},{-20,40},{-20,50}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Documentation(info="<HTML>
Test example with multiphase components:<br>
Star-connected voltage source feeds via a transformer a diode bridge rectifier with a DC burden.<br>
Using f=50 Hz, simulate for 0.1 seconds (5 periods) and compare voltages and currents of source and DC burden,
neglecting initial transient.
</HTML>"),
     experiment(StopTime=0.1, Interval=0.0001));
end Rectifier6pulse;
