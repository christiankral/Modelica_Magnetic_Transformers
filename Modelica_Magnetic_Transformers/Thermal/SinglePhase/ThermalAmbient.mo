within Modelica_Magnetic_Transformers.Thermal.SinglePhase;
model ThermalAmbient "Thermal ambient for single phase transformers"
  parameter Integer m(min=1) = 3 "Number of phases";
  parameter Boolean useTemperatureInputs=false
  "If true, temperature inputs are used; else, temperatures are constant"
    annotation (Evaluate=true);
  constant Modelica.SIunits.Temperature TDefault=293.15
  "Default temperature";
  parameter Modelica.SIunits.Temperature T1(start=TDefault)
  "Temperature of primary windings"
    annotation (Dialog(enable=not useTemperatureInputs));
  parameter Modelica.SIunits.Temperature T2(start=TDefault)
  "Temperature of secondary windings"
    annotation (Dialog(enable=not useTemperatureInputs));
  output Modelica.SIunits.HeatFlowRate Q_flow1=temperature1.port.Q_flow
  "Heat flow rate of primary windings";
  output Modelica.SIunits.HeatFlowRate Q_flow2=temperature2.port.Q_flow
  "Heat flow rate of secondary windings";
  output Modelica.SIunits.HeatFlowRate Q_flowCore=temperatureCore.port.Q_flow
  "Heat flow rate of core losses";
  output Modelica.SIunits.HeatFlowRate Q_flowTotal=Q_flow1 + Q_flow2 +
      Q_flowCore;
  Interfaces.SinglePhase.ThermalPortTransformer thermalPort
  annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperature1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,30})));
  Modelica.Blocks.Sources.Constant constT1(final k=T1) if not
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-10})));
  Modelica.Blocks.Interfaces.RealInput TPrimary if useTemperatureInputs
  "Temperature of primary windings"   annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-80,-100})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperature2
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={80,30})));
  Modelica.Blocks.Sources.Constant constT2(final k=T2) if not
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={80,-10})));
  Modelica.Blocks.Interfaces.RealInput TSecondary if useTemperatureInputs
  "Temperature of secondary windings"   annotation (Placement(
        transformation(
        extent={{-20,20},{20,-20}},
        rotation=90,
        origin={80,-100})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureCore(
      final T=TDefault) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,30})));
equation
  connect(TPrimary, temperature1.T) annotation (Line(
      points={{-80,-100},{-80,-60},{-100,-60},{-100,8},{-80,8},{-80,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(constT1.y, temperature1.T) annotation (Line(
      points={{-80,1},{-80,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSecondary, temperature2.T) annotation (Line(
      points={{80,-100},{80,-60},{100,-60},{100,8},{80,8},{80,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(constT2.y, temperature2.T) annotation (Line(
      points={{80,1},{80,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temperatureCore.port, thermalPort.heatPortCore) annotation (Line(
      points={{0,40},{0,100}},
      color={191,0,0},
      smooth=Smooth.None));
connect(temperature1.port, thermalPort.heatPort1) annotation (Line(
    points={{-80,40},{-80,100},{0,100}},
    color={191,0,0},
    smooth=Smooth.None));
connect(temperature2.port, thermalPort.heatPort2) annotation (Line(
    points={{80,40},{80,100},{0,100}},
    color={191,0,0},
    smooth=Smooth.None));
  annotation (Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),Line(
              points={{-14,0},{54,0}},
              color={191,0,0},
              thickness=0.5,
              origin={0,-6},
              rotation=90),Polygon(
              points={{-20,-20},{-20,20},{20,0},{-20,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid,
              origin={0,68},
              rotation=90),Text(
              extent={{-100,-20},{100,-80}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              textString="Trafo")}), Documentation(info="<HTML>
Thermal ambient for transformers to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</HTML>"),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
          {100,100}}), graphics));
end ThermalAmbient;
