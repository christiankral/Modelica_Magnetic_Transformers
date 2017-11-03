within Modelica_Magnetic_Transformers.Examples;
model ZeroSequence
"Operating a three phase transformer with zero sequence voltage"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage V=100*sqrt(2/3)
  "Amplitude of star-voltage";
  parameter Modelica.SIunits.Frequency f=50 "Frequency";

  Modelica.Electrical.MultiPhase.Sources.SineVoltage source(
    m=m,
    freqHz=fill(f, m),
    V=fill(V/100, m),
    phase=fill(Modelica.Constants.pi/2,m))    annotation (Placement(transformation(
        origin={-60,-10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.MultiPhase.Basic.Star starAC(m=m) annotation (
      Placement(transformation(
        origin={-60,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundAC annotation (Placement(
        transformation(extent={{-70,-80},{-50,-60}},  rotation=0)));
  Modelica.Electrical.MultiPhase.Sensors.CurrentSensor currentSensor(m=m)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}},
          rotation=0)));
  parameter Modelica.Electrical.Machines.Utilities.TransformerData transformerData(
    C1=Modelica.Utilities.Strings.substring(
        transformer.VectorGroup,
        1,
        1),
    C2=Modelica.Utilities.Strings.substring(
        transformer.VectorGroup,
        2,
        2),
    f=50,
    V1=100,
    V2=100,
    SNominal=30E3,
    v_sc=0.05,
    P_sc=000) annotation (Placement(transformation(extent={{-56,60},{-36,80}},
          rotation=0)));
BaseTransformers.ThreePhase.Yy.Yy00 transformer(
    alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    n=transformerData.n,
    R1=transformerData.R1,
    L1sigma=transformerData.L1sigma,
    R2=transformerData.R2,
    L2sigma=transformerData.L2sigma,
    L1m=0.3183,
  T1Ref=293.15,
  T2Ref=293.15,
  T1Operational=293.15,
  T2Operational=293.15,
  core=Modelica_Magnetic_Transformers.Types.ThreePhaseCore.symmetricCoreBackIron,
  L10=2E-5)               annotation (Placement(transformation(extent={{0,-10},{
            20,10}},   rotation=0)));

  Modelica.Electrical.Analog.Basic.Ground groundAC2
                                                   annotation (Placement(
        transformation(extent={{10,-80},{30,-60}},    rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground groundAC1
                                                   annotation (Placement(
        transformation(extent={{-10,-80},{10,-60}},   rotation=0)));
equation
  connect(starAC.plug_p,source. plug_n)
    annotation (Line(points={{-60,-30},{-60,-20}}, color={0,0,255}));
  connect(starAC.pin_n,groundAC. p)
    annotation (Line(points={{-60,-50},{-60,-60}}, color={0,0,255}));
  connect(source.plug_p,currentSensor. plug_p)
    annotation (Line(points={{-60,0},{-40,0}},         color={0,0,255}));
  connect(transformer.plug1, currentSensor.plug_n) annotation (Line(
      points={{0,0},{-20,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(groundAC2.p, transformer.starpoint2) annotation (Line(
      points={{20,-60},{20,-10},{15,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(transformer.starpoint1, groundAC1.p) annotation (Line(
      points={{5,-10},{0,-10},{0,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=0.1));
end ZeroSequence;
