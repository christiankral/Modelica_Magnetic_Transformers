within Modelica_Magnetic_Transformers.BaseTransformers.ThreePhase.Dy;
model Dy03 "Transformer Dy3"
  extends Modelica_Magnetic_Transformers.Interfaces.ThreePhase.Transformer(final VectorGroup="Dy03");
  Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
    annotation (Placement(transformation(
        origin={10,-80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
    annotation (Placement(transformation(extent={{40,-110},{60,-90}},
          rotation=0)));
  Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}},
          rotation=0)));
  Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
    annotation (Placement(transformation(extent={{40,-10},{60,10}},
          rotation=0)));
equation
  connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
          10,-100},{50,-100}}, color={0,0,255}));
  connect(Delta1.plug_n, transformer.plug_n1) annotation (Line(points={{-40,-40},
        {-10,-40},{-10,-6}},   color={0,0,255}));
  connect(transformer.plug_p2, Rot2.plug_p) annotation (Line(points={{10,10},
        {10,10},{20,10},{20,0},{30,0},{30,6.66134e-16},{40,6.66134e-16}},
                           color={0,0,255}));
  connect(transformer.plug_n2, transformer.plug_p3)
    annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
  connect(transformer.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
          {10,-40},{10,-70},{10,-70}}, color={0,0,255}));
connect(Delta1.plug_p, plug1) annotation (Line(
    points={{-60,-40},{-100,-40},{-100,0}},
    color={0,0,255},
    smooth=Smooth.None));
connect(transformer.plug_p1, plug1) annotation (Line(
    points={{-10,6},{-100,6},{-100,0}},
    color={0,0,255},
    smooth=Smooth.None));
connect(Rot2.plug_n, plug2) annotation (Line(
    points={{60,6.66134e-16},{80,6.66134e-16},{80,4.44089e-16},{100,
        4.44089e-16}},
    color={0,0,255},
    smooth=Smooth.None));
  annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy3
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
          -100},{100,100}}), graphics));
end Dy03;
