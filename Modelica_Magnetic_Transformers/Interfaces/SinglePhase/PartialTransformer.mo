within Modelica_Magnetic_Transformers.Interfaces.SinglePhase;
partial model PartialTransformer
"Partial internal single phase transformer model with resistances and stray inductances"
  extends Modelica_Magnetic_Transformers.Icons.SinglePhaseTransformer;
  parameter Real N1(start = 1) "Number of primary turns";
  parameter Real n(start = 1)
  "Ratio primary voltage (line-to-line) / secondary voltage (line-to-line)";
  parameter Modelica.SIunits.Resistance R1(start=5E-3)
  "Primary resistance per phase at TRef"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Temperature T1Ref(start=293.15)
  "Reference temperature of primary resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter
  Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20_1(start=0)
  "Temperature coefficient of primary resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance L1sigma(start=78E-6)
  "Primary stray inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Resistance R2(start=5E-3)
  "Secondary resistance per phase at TRef"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Temperature T2Ref(start=293.15)
  "Reference temperature of secondary resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter
  Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20_2(start=0)
  "Temperature coefficient of secondary resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance L2sigma(start=78E-6)
  "Secondary stray inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Boolean useThermalPort=false
  "Enable / disable (=fixed temperatures) thermal port"
    annotation (Evaluate=true);
  parameter Modelica.SIunits.Temperature T1Operational(start=293.15)
  "Operational temperature of primary resistance"   annotation (Dialog(
        group="Operational temperatures", enable=not useThermalPort));
  parameter Modelica.SIunits.Temperature T2Operational(start=293.15)
  "Operational temperature of secondary resistance"   annotation (Dialog(
        group="Operational temperatures", enable=not useThermalPort));
  output Modelica.SIunits.Voltage v1=p1.v-n1.v "Primary winding voltage";
  output Modelica.SIunits.Current i1=p1.i "Primary winding current";
  output Modelica.SIunits.Voltage v2=p2.v-n2.v
  "First tap of secondary winding voltage";
  output Modelica.SIunits.Current i2=p2.i
  "First tap of secondary winding current";
  output Modelica.SIunits.MagneticFlux Phi=winding1.port_p.Phi
  "Main flux of leg";
  output Modelica.SIunits.MagneticPotentialDifference V_m=
    winding1.port_p.V_m - winding2.port_n.V_m
  "Total magnetic voltage of leg";

  output Modelica.Electrical.Machines.Interfaces.PowerBalanceTransformer powerBalance(
    final power1=v1*i1,
    final power2=v2*i2,
    final lossPower1=winding1.resistor.LossPower,
    final lossPower2=winding2.resistor.LossPower,
    final lossPowerCore=0) "Power balance";

protected
  ThermalPortTransformer                                         internalThermalPort
    annotation (Placement(transformation(extent={{-4,76},{4,84}})));
public
  Modelica.Electrical.Analog.Interfaces.PositivePin p1
  "Positive primary pin"
    annotation (Placement(transformation(extent={{-90,50},{-110,70}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n1
  "Negative primary pin"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}},
          rotation=0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin p2
  "Positive secondary pin"
    annotation (Placement(transformation(extent={{110,50},{90,70}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n2
  "Negative secondary pin"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}}, rotation=0)));
 Components.SinglePhase.Winding winding1(
    final TRef=T1Ref,
    final Lsigma=L1sigma,
    final N=N1,
    final RRef=R1,
    final TOperational=T1Operational,
    final useHeatPort=useThermalPort,
    final alpha20=alpha20_1)
      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,0})));
  Components.SinglePhase.Winding winding2(
    final TRef=T2Ref,
    final useHeatPort=useThermalPort,
    final TOperational=T2Operational,
    final N=N1/n,
    final RRef=R2,
    final alpha20=alpha20_2,
    final Lsigma=L2sigma)
      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,0})));
Thermal.SinglePhase.ThermalAmbient thermalAmbient(
  final useTemperatureInputs=false,
  final T1=T1Operational,
  final T2=T2Operational) if   not useThermalPort annotation (Placement(
      transformation(
      extent={{-10,-10},{10,10}},
      rotation=270,
      origin={-30,80})));
public
  ThermalPortTransformer thermalPort if useThermalPort
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));
equation
  connect(internalThermalPort.heatPort1, winding1.heatPortWinding) annotation (
      Line(
      points={{0,80},{0,20},{-20,20},{-20,10}},
      color={199,0,0},
      smooth=Smooth.None));
  connect(winding2.heatPortWinding, internalThermalPort.heatPort2) annotation (
      Line(
      points={{20,10},{20,20},{0,20},{0,80}},
      color={191,0,0},
      smooth=Smooth.None));
connect(winding1.port_n, winding2.port_p) annotation (Line(
    points={{-10,0},{10,0}},
    color={255,127,0},
    smooth=Smooth.None));
  connect(winding1.pin_p, p1) annotation (Line(
      points={{-26,-10},{-26,-40},{-100,-40},{-100,60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(winding1.pin_n, n1) annotation (Line(
      points={{-14,-10},{-14,-60},{-100,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(winding2.pin_p, p2) annotation (Line(
      points={{14,-10},{14,-20},{100,-20},{100,60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(winding2.pin_n, n2) annotation (Line(
      points={{26,-10},{26,-60},{100,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(thermalAmbient.thermalPort, internalThermalPort) annotation (Line(
      points={{-20,80},{0,80}},
      color={199,0,0},
      smooth=Smooth.None));
  connect(internalThermalPort, thermalPort) annotation (Line(
      points={{0,80},{0,100}},
      color={199,0,0},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{0,100},{0,60}},
              lineColor={0,0,255},
              textString="%name")}), Documentation(info="<html>
Partial model of a three-phase transformer, containing primary and secondary resistances and stray inductances, as well as the iron core.
Circuit layout (vector group) of primary and secondary windings have to be defined.
<br><b>Default values for transformer's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td valign=\"top\">turns ratio n</td>
<td valign=\"top\">1</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">nominal frequency fNominal</td>
<td valign=\"top\">50</td><td valign=\"top\">Hz</td>
</tr>
<tr>
<td valign=\"top\">nominal voltage per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">V RMS</td>
</tr>
<tr>
<td valign=\"top\">nominal current per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">A RMS</td>
</tr>
<tr>
<td valign=\"top\">nominal apparent power</td>
<td valign=\"top\">30</td><td valign=\"top\">kVA</td>
</tr>
<tr>
<td valign=\"top\">primary resistance R1</td>
<td valign=\"top\">0.005</td><td valign=\"top\">Ohm per phase at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature T1Ref</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20_1 </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">primary stray inductance L1sigma</td>
<td valign=\"top\">78E-6</td><td valign=\"top\">H per phase</td>
</tr>
<tr>
<td valign=\"top\">secondary resistance R2</td>
<td valign=\"top\">0.005</td><td valign=\"top\">Ohm per phase at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature T2Ref</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20_2 </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">secondary stray inductance L2sigma</td>
<td valign=\"top\">78E-6</td><td valign=\"top\">H per phase</td>
</tr>
<tr>
<td valign=\"top\">operational temperature T1Operational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">operational temperature T2Operational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">These values give the operational parameters:</td>
<td valign=\"top\"> </td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">nominal voltage drop</td>
<td valign=\"top\">0.05</td><td valign=\"top\">p.u.</td>
</tr>
<tr>
<td valign=\"top\">nominal copper losses</td>
<td valign=\"top\">300</td><td valign=\"top\">W</td>
</tr>
</table>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),      graphics={
        Polygon(
          points={{-120,63},{-110,60},{-120,57},{-120,63}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{-136,60},{-111,60}}, color={160,160,164}),
        Line(points={{-136,-59},{-111,-59}}, color={160,160,164}),
        Polygon(
          points={{-126,-56},{-136,-59},{-126,-62},{-126,-56}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-127,-56},{-110,-41}},
          lineColor={160,160,164},
          textString="i1"),
        Text(
          extent={{-136,63},{-119,78}},
          lineColor={160,160,164},
          textString="i1"),
        Polygon(
          points={{127,-57},{137,-60},{127,-63},{127,-57}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{111,-60},{136,-60}}, color={160,160,164}),
        Text(
          extent={{112,-54},{128,-39}},
          lineColor={160,160,164},
          textString="i2"),
        Text(
          extent={{118,62},{135,77}},
          lineColor={160,160,164},
          textString="i2"),
        Polygon(
          points={{120,63},{110,60},{120,57},{120,63}},
          lineColor={160,160,164},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),
        Line(points={{111,60},{136,60}}, color={160,160,164})}));
end PartialTransformer;
