within Modelica_Magnetic_Transformers.Interfaces.ThreePhase;
partial model PartialTransformer
"Partial internal three phase transformer model with resistances and stray inductances"
  extends Modelica_Magnetic_Transformers.Icons.ThreePhaseTransformer;
  final parameter Integer m(min=1) = 3 "Number of phases";
  parameter String VectorGroup="Yy00";
  parameter Real N1 = 1 "Number of primary turns";
  parameter Real n = 1
  "Ratio primary voltage (line-to-line) / secondary voltage (line-to-line)";
  parameter Modelica.SIunits.Resistance R1(start=5E-3/(if C1 == "D" then 1
         else 3)) "Primary resistance per phase at TRef"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Temperature T1Ref(start=293.15)
  "Reference temperature of primary resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter
  Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20_1(start=0)
  "Temperature coefficient of primary resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance L1sigma(start=78E-6/(if C1 == "D"
         then 1 else 3)) "Primary stray inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Resistance R2(start=5E-3/(if C2 == "d" then 1
         else 3)) "Secondary resistance per phase at TRef"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Temperature T2Ref(start=293.15)
  "Reference temperature of secondary resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter
  Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20_2(start=0)
  "Temperature coefficient of secondary resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance L2sigma(start=78E-6/(if C2 == "d"
         then 1 else 3)) "Secondary stray inductance per phase"
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
  output Modelica.SIunits.Voltage v1[m]=plug_p1.pin.v-plug_n1.pin.v
  "Primary winding voltage";
  output Modelica.SIunits.Current i1[m]=plug_p1.pin.i
  "Primary winding current";
  output Modelica.SIunits.Voltage v2[m]=plug_p2.pin.v-plug_n2.pin.v
  "First tap of secondary winding voltage";
  output Modelica.SIunits.Current i2[m]=plug_p2.pin.i
  "First tap of secondary winding current";
  output Modelica.SIunits.Voltage v3[m]=plug_p3.pin.v-plug_n2.pin.v
  "Second tap of secondary winding voltage";
  output Modelica.SIunits.Current i3[m]=plug_p3.pin.i
  "Second tap of secondary winding current";
  output Modelica.SIunits.MagneticFlux Phi1=winding1.port_p1.Phi
  "Main flux of leg 1";
  output Modelica.SIunits.MagneticPotentialDifference V_m1=
    winding1.port_p1.V_m - winding3.port_n1.V_m
  "Total magnetic voltage of leg 1";
  output Modelica.SIunits.MagneticFlux Phi2=winding1.port_p2.Phi
  "Main flux of leg 2";
  output Modelica.SIunits.MagneticPotentialDifference V_m2=
    winding1.port_p2.V_m - winding3.port_n2.V_m
  "Total magnetic voltage of leg 2";
  output Modelica.SIunits.MagneticFlux Phi3=winding1.port_p3.Phi
  "Main flux of leg 3";
  output Modelica.SIunits.MagneticPotentialDifference V_m3=
    winding1.port_p3.V_m - winding3.port_n3.V_m
  "Total magnetic voltage of leg 3";

  output Modelica.Electrical.Machines.Interfaces.PowerBalanceTransformer powerBalance(
    final power1=
        Modelica.Electrical.Machines.SpacePhasors.Functions.activePower(v1,
        +i1),
    final power2=
        Modelica.Electrical.Machines.SpacePhasors.Functions.activePower(v2,
        +i2),
    final lossPower1=sum(winding1.resistor.resistor.LossPower),
    final lossPower2=sum(winding2.resistor.resistor.LossPower
                        +winding3.resistor.resistor.LossPower),
    final lossPowerCore=0) "Power balance";
protected
  final parameter String C1=Modelica.Utilities.Strings.substring(
          VectorGroup,
          1,
          1);
  final parameter String C2=Modelica.Utilities.Strings.substring(
          VectorGroup,
          2,
          2);
  parameter Real ni=n*(if C2 == "z" then sqrt(3) else 2)*(if C2 == "d"
       then 1 else sqrt(3))/(if C1 == "D" then 1 else sqrt(3));
public
  Modelica.Electrical.Machines.Interfaces.ThermalPortTransformer thermalPort(final m=m) if
       useThermalPort
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Machines.Thermal.ThermalAmbientTransformer thermalAmbient(
    final useTemperatureInputs=false,
    final T1=T1Operational,
    final T2=T2Operational,
    final m=m) if not useThermalPort annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,80})));
protected
  Modelica.Electrical.Machines.Interfaces.ThermalPortTransformer internalThermalPort(final m=m)
    annotation (Placement(transformation(extent={{-4,76},{4,84}})));
public
  Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p1(
    final m=m) "Positive electric plug"
                            annotation (Placement(transformation(extent={{-90,50},
            {-110,70}},     rotation=0)));
  Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n1(
    final m=m) "Negative electric plug"
                            annotation (Placement(transformation(extent={{-110,-70},
            {-90,-50}},      rotation=0)));
  Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p2(
    final m=m) "Positive electric plug"
                            annotation (Placement(transformation(extent={{110,90},
            {90,110}},      rotation=0)));
  Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n2(
    final m=m) "Negative electric plug"
                            annotation (Placement(transformation(extent={{90,30},
            {110,50}},       rotation=0)));
  Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n3(
    final m=m) "Negative electric plug"
                            annotation (Placement(transformation(extent={{90,-110},
            {110,-90}},      rotation=0)));
  Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p3(
    final m=m) "Positive electric plug"
                            annotation (Placement(transformation(extent={{110,-50},
            {90,-30}},      rotation=0)));
  Components.ThreePhase.Winding winding1(
    final m=m,
    final TRef=T1Ref,
    final Lsigma=L1sigma,
    final N=N1,
    final RRef=R1,
    final TOperational=T1Operational,
    final useHeatPort=useThermalPort,
    final alpha20=alpha20_1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,0})));
  Components.ThreePhase.Winding winding2(
    final m=m,
    final TRef=T2Ref,
    final Lsigma=L2sigma/2,
    final RRef=R2/2,
    final useHeatPort=useThermalPort,
    final TOperational=T2Operational,
    final N=N1/ni,
    final alpha20=alpha20_2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));
public
  Components.ThreePhase.Winding winding3(
    final m=m,
    final TRef=T2Ref,
    final Lsigma=L2sigma/2,
    final RRef=R2/2,
    final useHeatPort=useThermalPort,
    final TOperational=T2Operational,
    final N=N1/ni,
    final alpha20=alpha20_2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,0})));
equation
  connect(thermalPort, internalThermalPort) annotation (Line(
      points={{0,100},{0,80}},
      color={199,0,0},
      smooth=Smooth.None));
  connect(thermalAmbient.thermalPort, internalThermalPort) annotation (Line(
      points={{-20,80},{0,80}},
      color={199,0,0},
      smooth=Smooth.None));
  connect(internalThermalPort.heatPort1, winding1.heatPortWinding) annotation (
      Line(
      points={{0,80},{0,20},{-30,20},{-30,10}},
      color={199,0,0},
      smooth=Smooth.None));
  connect(winding2.heatPortWinding, internalThermalPort.heatPort2) annotation (
      Line(
      points={{1.11022e-15,10},{1.11022e-15,20},{0,20},{0,80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(winding1.port_n1, winding2.port_p1) annotation (Line(
      points={{-20,-10},{-10,-10}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(winding1.port_n2, winding2.port_p2) annotation (Line(
      points={{-20,0},{-20,1.33227e-15},{-10,1.33227e-15}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(winding1.port_n3, winding2.port_p3) annotation (Line(
      points={{-20,10},{-10,10}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(winding2.port_n1, winding3.port_p1) annotation (Line(
      points={{10,-10},{20,-10}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(winding2.port_n2, winding3.port_p2) annotation (Line(
      points={{10,0},{10,1.33227e-15},{20,1.33227e-15}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(winding2.port_n3, winding3.port_p3) annotation (Line(
      points={{10,10},{20,10}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(winding3.heatPortWinding, internalThermalPort.heatPort2) annotation (
      Line(
      points={{30,10},{30,20},{0,20},{0,80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(winding1.plug_p, plug_p1) annotation (Line(
      points={{-36,-10},{-36,-40},{-100,-40},{-100,60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(winding1.plug_n, plug_n1) annotation (Line(
      points={{-24,-10},{-24,-60},{-100,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(winding2.plug_p, plug_p2) annotation (Line(
      points={{-6,-10},{-6,-30},{80,-30},{80,100},{100,100}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(winding2.plug_n, plug_n2) annotation (Line(
      points={{6,-10},{6,-20},{100,-20},{100,40},{100,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(winding3.plug_p, plug_p3) annotation (Line(
      points={{24,-10},{24,-40},{100,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(winding3.plug_n, plug_n3) annotation (Line(
      points={{36,-10},{36,-100},{100,-100}},
      color={0,0,255},
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
          points={{127,43},{137,40},{127,37},{127,43}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{111,40},{136,40}},   color={160,160,164}),
        Text(
          extent={{112,46},{128,61}},
          lineColor={160,160,164},
          textString="i2"),
        Text(
          extent={{118,102},{135,117}},
          lineColor={160,160,164},
          textString="i2"),
        Polygon(
          points={{120,103},{110,100},{120,97},{120,103}},
          lineColor={160,160,164},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),
        Line(points={{111,100},{136,100}}, color={160,160,164}),
        Polygon(
          points={{127,-97},{137,-100},{127,-103},{127,-97}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{111,-100},{136,-100}},
                                           color={160,160,164}),
        Text(
          extent={{112,-94},{128,-79}},
          lineColor={160,160,164},
          textString="i3"),
        Text(
          extent={{118,-38},{135,-23}},
          lineColor={160,160,164},
          textString="i3"),
        Polygon(
          points={{120,-37},{110,-40},{120,-43},{120,-37}},
          lineColor={160,160,164},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),
        Line(points={{111,-40},{136,-40}}, color={160,160,164})}));
end PartialTransformer;
