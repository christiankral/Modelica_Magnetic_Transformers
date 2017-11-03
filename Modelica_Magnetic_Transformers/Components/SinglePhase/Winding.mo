within Modelica_Magnetic_Transformers.Components.SinglePhase;
model Winding "Single phase windings located on three different legs"

  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
  "Positive electric pin"   annotation (Placement(transformation(extent={{-90,50},
          {-110,70}},   rotation=0), iconTransformation(extent={{-90,50},
          {-110,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
  "Negative electric pin"   annotation (Placement(transformation(extent={{-110,
          -70},{-90,-50}},
                        rotation=0), iconTransformation(extent={{-110,-70},
          {-90,-50}})));

  parameter Boolean useHeatPort=false
  "Enable / disable (=fixed temperatures) thermal port"
    annotation (Evaluate=true);
  parameter Real N = 1 "Number of turns per phase";
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
  Modelica.SIunits.Voltage v "Voltage";
  Modelica.SIunits.Current i(start=0, stateSelect=StateSelect.prefer)
  "Current";
  Modelica.SIunits.MagneticPotentialDifference V_m
  "Magnetic potential differences";
  Modelica.SIunits.MagneticFlux Phi
  "Magnetic fluxes coupled into magnetic circuit";

  Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_p
  "Positive magnetic port"   annotation (Placement(transformation(extent={{-10,90},
          {10,110}},  rotation=0), iconTransformation(extent={{-10,90},{
          10,110}})));
  Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort port_n
  "Negative magnetic port"   annotation (Placement(transformation(extent={{10,-90},
          {-10,-110}},  rotation=0)));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if
    useHeatPort "Heat port of winding resistor"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter
                                      converter(final N=N)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Electrical.Analog.Basic.Resistor     resistor(
    final useHeatPort=useHeatPort,
    final R=RRef,
    final T_ref=TRef,
    final alpha=alphaRef,
    final T=TOperational)
    annotation (Placement(transformation(extent={{-80,-4},{-60,16}})));
  Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance strayPermeance1(final G_m=
       Lsigma/N^2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,0})));
equation
  v = pin_p.v - pin_n.v;
  i = pin_p.i;

  V_m = port_p.V_m - port_n.V_m;
  Phi = port_p.Phi;

  connect(strayPermeance1.port_p, port_p) annotation (Line(
      points={{2.44249e-15,10},{2.44249e-15,100},{4.44089e-16,100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(strayPermeance1.port_n, port_n) annotation (Line(
      points={{-1.33227e-15,-10},{-1.33227e-15,-100},{-4.44089e-16,-100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(resistor.heatPort, heatPortWinding) annotation (Line(
      points={{-70,-4},{-70,-40},{100,-40},{100,4.44089e-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pin_p, resistor.p) annotation (Line(
      points={{-100,60},{-100,6},{-80,6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor.n, converter.p) annotation (Line(
      points={{-60,6},{-40,6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(converter.n, pin_n) annotation (Line(
      points={{-40,-6},{-100,-6},{-100,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(converter.port_p, port_p) annotation (Line(
      points={{-20,6},{-20,100},{4.44089e-16,100}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(converter.port_n, port_n) annotation (Line(
      points={{-20,-6},{-20,-100},{-4.44089e-16,-100}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{0,100},{0,-100}},
          color={255,128,0},
          smooth=Smooth.None),
        Line(
          points={{-100,60},{-100,60},{4,60},{24,12},{4,-30},{-6,-30},{
            -20,0},{-6,30},{4,30},{24,-12},{4,-60},{-100,-60},{-100,-60}},
          color={0,0,255},
          smooth=Smooth.None)}));
end Winding;
