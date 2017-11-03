within Modelica_Magnetic_Transformers.Components.ThreePhase;
model Winding
"Symmetric three phase windings located on three different legs"

  Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
  "Positive electric plug"  annotation (Placement(transformation(extent={{-90,50},
          {-110,70}},       rotation=0), iconTransformation(extent={{-90,50},
          {-110,70}})));
  Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
  "Negative electric plug"  annotation (Placement(transformation(extent={{-110,
          -70},{-90,-50}},   rotation=0), iconTransformation(extent={{-110,
          -70},{-90,-50}})));

  constant Integer m = 3 "Number of phases";
  parameter Boolean useHeatPort=false
  "Enable / disable (=fixed temperatures) thermal port"
    annotation (Evaluate=true);
  parameter Real N=1 "Number of turns per phase";
  parameter Modelica.SIunits.Resistance RRef
  "Winding resistance per phase at TRef";
  parameter Modelica.SIunits.Temperature TRef(start=293.15)
  "Reference temperature of winding";
  parameter
  Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20(start=0) "Temperature coefficient of winding at 20 degC";
  final parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef=
      Modelica.Electrical.Machines.Thermal.convertAlpha(
            alpha20,
            TRef,
            293.15);
  parameter Modelica.SIunits.Temperature TOperational(start=293.15)
  "Operational temperature of winding"
    annotation (Dialog(enable=not useHeatPort));
  parameter Modelica.SIunits.Inductance Lsigma
  "Winding stray inductance per phase";
  /*
  parameter Modelica.SIunits.Inductance Lzero 
    "Zero sequence inductance of winding";
  */
  Modelica.SIunits.Voltage v[m] "Voltage";
  Modelica.SIunits.Current i[m](start=zeros(m), stateSelect=fill(StateSelect.prefer,m))
  "Current";
  Modelica.SIunits.MagneticPotentialDifference V_m[m]
  "Magnetic potential differences";
  Modelica.SIunits.MagneticFlux Phi[m]
  "Magnetic fluxes coupled into magnetic circuit";

  Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_p1
  "Positive magnetic port 1"   annotation (Placement(transformation(extent={{-110,90},
          {-90,110}},         rotation=0), iconTransformation(extent={{-110,90},
          {-90,110}})));
  Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort port_n1
  "Negative magnetic port 1"   annotation (Placement(transformation(extent={{-90,-90},
          {-110,-110}},         rotation=0)));
  Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_p2
  "Positive magnetic port 2"   annotation (Placement(transformation(extent={{-10,90},
          {10,110}},          rotation=0)));
  Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort port_n2
  "Negative magnetic port 2"   annotation (Placement(transformation(extent={{10,-90},
          {-10,-110}},          rotation=0)));
  Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_p3
  "Positive magnetic port 3"   annotation (Placement(transformation(extent={{90,90},
          {110,110}},         rotation=0)));
  Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort port_n3
  "Negative magnetic port 3"   annotation (Placement(transformation(extent={{110,-90},
          {90,-110}},           rotation=0)));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding[m] if
    useHeatPort "Heat ports of winding resistors"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  ThreePhase.ElectroMagneticConverter converter(final N=fill(N, m))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.MultiPhase.Basic.Resistor resistor(
    final m=m,
    final useHeatPort=useHeatPort,
    final T_ref=fill(TRef, m),
    final alpha=fill(alphaRef, m),
    final T=fill(TOperational, m),
    final R=fill(RRef, m))
    annotation (Placement(transformation(extent={{-80,-4},{-60,16}})));
  Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance strayPermeance1(final G_m=
       Lsigma/N^2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,50})));
  Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance strayPermeance2(final G_m=
       Lsigma/N^2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,50})));
  Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance strayPermeance3(final G_m=
       Lsigma/N^2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,50})));
equation
  v = plug_p.pin.v - plug_n.pin.v;
  i = plug_p.pin.i;

  V_m[1] = port_p1.V_m - port_n1.V_m;
  V_m[2] = port_p2.V_m - port_n2.V_m;
  V_m[3] = port_p3.V_m - port_n3.V_m;
  Phi = {port_p1.Phi,port_p2.Phi,port_p3.Phi};

  connect(plug_p, resistor.plug_p) annotation (Line(
      points={{-100,60},{-100,6},{-80,6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor.plug_n, converter.plug_p) annotation (Line(
      points={{-60,6},{-10,6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(converter.plug_n, plug_n) annotation (Line(
      points={{-10,-6},{-100,-6},{-100,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(converter.port_p1, port_p1) annotation (Line(
      points={{-10,10},{-40,10},{-40,100},{-100,100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(converter.port_n1, port_n1) annotation (Line(
      points={{-10,-10},{-40,-10},{-40,-100},{-100,-100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(converter.port_p2, port_p2) annotation (Line(
      points={{0,10},{0,100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(converter.port_n2, port_n2) annotation (Line(
      points={{0,-10},{0,-100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(converter.port_p3, port_p3) annotation (Line(
      points={{10,10},{40,10},{40,100},{100,100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(converter.port_n3, port_n3) annotation (Line(
      points={{10,-10},{40,-10},{40,-100},{100,-100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(strayPermeance3.port_p, port_p3) annotation (Line(
      points={{60,60},{60,100},{100,100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(strayPermeance3.port_n, port_n3) annotation (Line(
      points={{60,40},{60,-100},{100,-100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(strayPermeance2.port_p, port_p2) annotation (Line(
      points={{20,60},{20,100},{4.44089e-16,100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(strayPermeance2.port_n, port_n2) annotation (Line(
      points={{20,40},{20,-100},{-4.44089e-16,-100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(strayPermeance1.port_p, port_p1) annotation (Line(
      points={{-20,60},{-20,100},{-100,100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(strayPermeance1.port_n, port_n1) annotation (Line(
      points={{-20,40},{-20,-100},{-100,-100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(resistor.heatPort, heatPortWinding) annotation (Line(
      points={{-70,-4},{-70,-40},{100,-40},{100,4.44089e-16}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
          -100},{100,100}}),   graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{-92,98},{-84,92},{-78,84},{-72,72},{-66,54},{-64,44},{
              -62,30},{-60,14},{-60,0}},
          color={255,128,0},
          smooth=Smooth.None),
        Line(
          points={{0,100},{0,-100}},
          color={255,128,0},
          smooth=Smooth.None),
        Line(
          points={{90,98},{82,92},{76,84},{70,72},{64,54},{62,44},{60,30},{
              58,14},{58,0}},
          color={255,128,0},
          smooth=Smooth.None),
        Line(
          points={{90,-98},{82,-92},{76,-84},{70,-72},{64,-54},{62,-44},{60,
              -30},{58,-14},{58,0}},
          color={255,128,0},
          smooth=Smooth.None),
        Line(
          points={{-92,-98},{-84,-92},{-78,-84},{-72,-72},{-66,-54},{-64,
              -44},{-62,-30},{-60,-14},{-60,0}},
          color={255,128,0},
          smooth=Smooth.None),
        Line(
          points={{-100,60},{-100,60},{-60,60},{-40,20},{-60,-20},{-70,
            -20},{-80,0},{-70,22},{-60,22},{-40,-10},{-60,-60},{-100,-60},
            {-100,-60}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-36,60},{-36,60},{4,60},{24,18},{4,-22},{-6,-22},{-16,
            -2},{-6,20},{4,20},{24,-12},{4,-60},{-36,-60},{-36,-60}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{24,60},{24,60},{64,60},{84,20},{64,-20},{54,-20},{44,0},
            {54,22},{64,22},{84,-10},{64,-60},{24,-60},{24,-60}},
          color={0,0,255},
          smooth=Smooth.None)}));
end Winding;
