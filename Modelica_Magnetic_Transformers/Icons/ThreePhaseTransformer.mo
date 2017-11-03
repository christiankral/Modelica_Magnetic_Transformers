within Modelica_Magnetic_Transformers.Icons;
model ThreePhaseTransformer "Three phase transformer"

  annotation (Icon(graphics={Polygon(
              points={{-70,60},{-50,40},{-50,-40},{-70,-60},{-70,60}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder),Polygon(
              points={{70,60},{50,40},{50,-40},{70,-60},{70,60}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder),Polygon(
              points={{0,50},{-10,40},{-10,-40},{0,-50},{10,-40},{10,40},{0,
            50}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              smooth=Smooth.None,
              fillColor={135,135,135}),Polygon(
              points={{-70,60},{70,60},{50,40},{10,40},{0,50},{-10,40},{-50,
            40},{-70,60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              smooth=Smooth.None,
              fillColor={135,135,135}),Polygon(
              points={{-70,-60},{70,-60},{50,-40},{10,-40},{0,-50},{-10,-40},
            {-50,-40},{-70,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              smooth=Smooth.None,
              fillColor={135,135,135}),Rectangle(
              extent={{-78,36},{-42,-36}},
              lineColor={128,0,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={128,0,255}),Rectangle(
          extent={{-84,28},{-36,-28}},
          lineColor={255,128,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}),    Rectangle(
              extent={{-18,36},{18,-36}},
              lineColor={128,0,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={128,0,255}),Rectangle(
          extent={{-24,28},{24,-28}},
          lineColor={255,128,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}),    Rectangle(
              extent={{42,36},{78,-36}},
              lineColor={128,0,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={128,0,255}),Rectangle(
          extent={{36,28},{84,-28}},
          lineColor={255,128,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0})}),     Documentation(info="<html>
<p>
This icon is designed for a <b>transient transformer</b> model.
</p>
</html>"));
end ThreePhaseTransformer;
