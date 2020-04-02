<?xml version="1.0"?>
<root xmlns="http://www.vips.ecs.soton.ac.uk/nip/8.7.1">
  <Workspace window_x="0" window_y="28" window_width="1920" window_height="1052" view="WORKSPACE_MODE_REGULAR" scale="1" offset="0" locked="false" lpane_position="456" lpane_open="false" rpane_position="100" rpane_open="false" local_defs="&#10;// accumulate a list&#10;// [1, 2, 5, 12] -&gt; [1, 3, 8, 20]&#10;accumulate l&#10;&#9;= reverse (foldl fn [hd l] (tl l))&#10;{&#10;&#9;fn l x = (x + hd l) : l;&#10;}&#10;" name="inputs" caption="Default empty workspace" filename="$HOME/pics/covid19/find-lungs.ws" major="8" minor="7">
    <Column x="0" y="0" open="true" selected="true" sform="false" next="7" name="A" caption="images">
      <Subcolumn vislevel="3">
        <Row popup="false" name="A2">
          <Rhs vislevel="1" flags="1">
            <iImage window_x="29" window_y="29" window_width="526" window_height="750" image_left="250" image_top="311" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="Image_file &quot;$HOME/pics/covid19/nifti/Case_001.nii.gz&quot;"/>
          </Rhs>
        </Row>
        <Row popup="false" name="A3">
          <Rhs vislevel="1" flags="4">
            <iText formula="path_parse A2.filename"/>
          </Rhs>
        </Row>
        <Row popup="false" name="basedir">
          <Rhs vislevel="1" flags="4">
            <iText formula="path_relative (init A3)"/>
          </Rhs>
        </Row>
        <Row popup="false" name="A6">
          <Rhs vislevel="1" flags="4">
            <iText formula="get_header &quot;page-height&quot; A2"/>
          </Rhs>
        </Row>
        <Row popup="false" name="slices">
          <Rhs vislevel="1" flags="4">
            <iText formula="A2.height / A6"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
  </Workspace>
  <Workspace window_x="0" window_y="28" window_width="1920" window_height="1052" view="WORKSPACE_MODE_REGULAR" scale="1" offset="0" locked="false" lpane_position="451" lpane_open="false" rpane_position="856" rpane_open="false" local_defs="// make an indexed volume&#10;make_xyz x y z&#10;&#9;= map (join xy) zeds&#10;{&#10;&#9;black = im_black x y 1;&#10;&#9;zeds = map (cast_unsigned_int @ add black) [0 .. z - 1];&#10;&#9;xy = make_xy x y;&#10;}&#10;&#10;flood_black i pos&#10;  = Image i'&#10;{&#10;  i' = im_draw_flood_blob i.value x y [0];&#10;  (x, y) = pos;&#10;}" name="image" caption="Default empty workspace" filename="$HOME/pics/covid19/find-lungs.ws" major="8" minor="7">
    <Column x="0" y="0" open="true" selected="true" sform="false" next="25" name="LB" caption="load transmission image">
      <Subcolumn vislevel="3">
        <Row popup="false" name="LB4">
          <Rhs vislevel="2" flags="5">
            <iText formula="inputs.A2"/>
            <iImage window_x="1014" window_y="164" window_width="618" window_height="783" image_left="296" image_top="23229" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="18.846029634256443" offset="-1000" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
          </Rhs>
        </Row>
        <Row popup="false" name="LB18">
          <Rhs vislevel="1" flags="4">
            <iText formula="&quot;we have 12-bit data in a 16-bit file, so imagemagick shifts it&quot;"/>
          </Rhs>
        </Row>
        <Row popup="false" name="LB14">
          <Rhs vislevel="1" flags="4">
            <iText formula="&quot;convert to g/cm^3&quot;"/>
          </Rhs>
        </Row>
        <Row popup="false" name="LB15">
          <Rhs vislevel="1" flags="4">
            <iText formula="&quot;comes in hounsfield units, offset by 1024, scaled by 1000&quot;"/>
          </Rhs>
        </Row>
        <Row popup="false" name="LB17">
          <Rhs vislevel="0" flags="4">
            <iImage window_x="1196" window_y="6" window_width="526" window_height="750" image_left="247" image_top="22759" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="106.5357543688625" offset="2.5568581270777901" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="(LB4 + 1024) / 1000"/>
          </Rhs>
        </Row>
        <Row popup="false" name="LB12">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="127" window_y="369" window_width="867" window_height="679" image_left="14874" image_top="283" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="110.40750839190207" offset="1.4945054712227432" falsecolour="true" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="grid 512 inputs.slices 1 LB17"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
    <Column x="270" y="0" open="true" selected="false" sform="false" next="18" name="output" caption="">
      <Subcolumn vislevel="3">
        <Row popup="false" name="output15">
          <Rhs vislevel="1" flags="4">
            <iText formula="&quot;full-res transmission image&quot;"/>
          </Rhs>
        </Row>
        <Row popup="false" name="output14">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="53" window_y="50" window_width="1058" window_height="551" image_left="87998" image_top="288" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="157.04370994139231" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="LB12"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
  </Workspace>
  <Workspace window_x="0" window_y="28" window_width="1920" window_height="1052" view="WORKSPACE_MODE_REGULAR" scale="1" offset="0" locked="false" lpane_position="451" lpane_open="false" rpane_position="856" rpane_open="false" local_defs="// make an indexed volume&#10;make_xyz x y z&#10;&#9;= map (join xy) zeds&#10;{&#10;&#9;black = im_black x y 1;&#10;&#9;zeds = map (cast_unsigned_int @ add black) [0 .. z - 1];&#10;&#9;xy = make_xy x y;&#10;}&#10;&#10;flood_black i pos&#10;  = Image i'&#10;{&#10;  i' = im_draw_flood_blob i.value x y [0];&#10;  (x, y) = pos;&#10;}" name="marklung" caption="Default empty workspace" filename="$HOME/pics/covid19/find-lungs.ws" major="8" minor="7">
    <Column x="0" y="0" open="false" selected="false" sform="false" next="3" name="B" caption="links to other workspaces">
      <Subcolumn vislevel="3">
        <Row popup="false" name="B1">
          <Rhs vislevel="1" flags="4">
            <iText formula="Workspaces.inputs"/>
          </Rhs>
        </Row>
        <Row popup="false" name="B2">
          <Rhs vislevel="1" flags="4">
            <iText formula="Workspaces.image"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
    <Column x="267" y="0" open="true" selected="true" sform="false" next="10" name="C" caption="mark lung top and bottom">
      <Subcolumn vislevel="3">
        <Row popup="false" name="C1">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="960" window_y="251" window_width="814" window_height="656" image_left="77393" image_top="52110" image_mag="-193" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="91.392306690855321" offset="0" falsecolour="true" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="B2.output14"/>
          </Rhs>
        </Row>
        <Row popup="false" name="C2">
          <Rhs vislevel="1" flags="1">
            <iArrow left="5358" top="294" width="0" height="0">
              <iRegiongroup/>
            </iArrow>
            <Subcolumn vislevel="0"/>
            <iText formula="Mark C1 15536 361"/>
          </Rhs>
        </Row>
        <Row popup="false" name="C3">
          <Rhs vislevel="1" flags="1">
            <iArrow left="141662" top="0" width="0" height="0">
              <iRegiongroup/>
            </iArrow>
            <Subcolumn vislevel="0"/>
            <iText formula="Mark C1 40657 363"/>
          </Rhs>
        </Row>
        <Row popup="false" name="C4">
          <Rhs vislevel="1" flags="4">
            <iText formula="&quot;slice range&quot;"/>
          </Rhs>
        </Row>
        <Row popup="false" name="C5">
          <Rhs vislevel="1" flags="4">
            <iText formula="(int) (C2.left / C1.height)"/>
          </Rhs>
        </Row>
        <Row popup="false" name="C6">
          <Rhs vislevel="1" flags="4">
            <iText formula="(int) (C3.left / C1.height)"/>
          </Rhs>
        </Row>
        <Row popup="false" name="C9">
          <Rhs vislevel="1" flags="4">
            <iText formula="&quot;number of slices&quot;"/>
          </Rhs>
        </Row>
        <Row popup="false" name="C7">
          <Rhs vislevel="1" flags="4">
            <iText formula="C6 - C5"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
    <Column x="267" y="431" open="true" selected="false" sform="false" next="9" name="J" caption="mark bed line">
      <Subcolumn vislevel="3">
        <Row popup="false" name="J1">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="2" window_y="56" window_width="750" window_height="551" image_left="45888" image_top="804" image_mag="-4" show_status="true" show_paintbox="false" show_convert="true" show_rulers="true" scale="91.392306690855321" offset="0" falsecolour="true" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="B2.output14"/>
          </Rhs>
        </Row>
        <Row popup="false" name="J7">
          <Rhs vislevel="2" flags="5">
            <iArrow left="0" top="360" width="154112" height="0">
              <iRegiongroup/>
            </iArrow>
            <Subcolumn vislevel="0"/>
            <iText formula="HGuide J1 432"/>
          </Rhs>
        </Row>
        <Row popup="false" name="J8">
          <Rhs vislevel="1" flags="4">
            <iText formula="J7.top"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
    <Column x="535" y="0" open="true" selected="false" sform="false" next="7" name="output">
      <Subcolumn vislevel="3">
        <Row popup="false" name="output1">
          <Rhs vislevel="1" flags="4">
            <iText formula="C5"/>
          </Rhs>
        </Row>
        <Row popup="false" name="output2">
          <Rhs vislevel="1" flags="4">
            <iText formula="C6"/>
          </Rhs>
        </Row>
        <Row popup="false" name="output3">
          <Rhs vislevel="1" flags="4">
            <iText formula="J8"/>
          </Rhs>
        </Row>
        <Row popup="false" name="output5">
          <Rhs vislevel="1" flags="4">
            <iText formula="D2"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
    <Column x="267" y="676" open="true" selected="false" sform="false" next="3" name="D" caption="erode lung by">
      <Subcolumn vislevel="3">
        <Row popup="false" name="D1">
          <Rhs vislevel="1" flags="4">
            <iText formula="&quot;erode lung by this many 512x512 pixels&quot;"/>
          </Rhs>
        </Row>
        <Row popup="false" name="D2">
          <Rhs vislevel="1" flags="4">
            <iText formula="5"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
  </Workspace>
  <Workspace window_x="0" window_y="28" window_width="1920" window_height="1052" view="WORKSPACE_MODE_REGULAR" scale="1" offset="0" locked="false" lpane_position="451" lpane_open="false" rpane_position="856" rpane_open="false" local_defs="// make an indexed volume&#10;make_xyz x y z&#10;&#9;= map (join xy) zeds&#10;{&#10;&#9;black = im_black x y 1;&#10;&#9;zeds = map (cast_unsigned_int @ add black) [0 .. z - 1];&#10;&#9;xy = make_xy x y;&#10;}&#10;&#10;flood_black i pos&#10;  = Image i'&#10;{&#10;  i' = im_draw_flood_blob i.value x y [0];&#10;  (x, y) = pos;&#10;}" name="lungmask" caption="Default empty workspace" filename="$HOME/pics/covid19/find-lungs.ws" major="7" minor="40">
    <Column x="1271" y="0" open="true" selected="false" sform="false" next="15" name="DB" caption="mask off top and bottom of lung">
      <Subcolumn vislevel="3">
        <Row popup="false" name="DB1">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="0" window_y="30" window_width="750" window_height="670" image_left="368" image_top="288" image_mag="1" show_status="true" show_paintbox="false" show_convert="false" show_rulers="false" scale="27" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="G3"/>
          </Rhs>
        </Row>
        <Row popup="false" name="DB13">
          <Rhs vislevel="1" flags="4">
            <iText formula="DB1.height"/>
          </Rhs>
        </Row>
        <Row popup="false" name="DB8">
          <Rhs vislevel="1" flags="4">
            <iText formula="make_xy DB1.width DB1.height"/>
          </Rhs>
        </Row>
        <Row popup="false" name="DB9">
          <Rhs vislevel="1" flags="4">
            <iText formula="DB8?0 &gt; (marklung.output1 - 1) * DB13 &amp; DB8?0 &lt; (marklung.output2 - 1) * DB13"/>
          </Rhs>
        </Row>
        <Row popup="false" name="DB10">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="361" window_y="212" window_width="1153" window_height="840" image_left="55976" image_top="374" image_mag="1" show_status="true" show_paintbox="false" show_convert="false" show_rulers="false" scale="27" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="DB1 &amp; DB9"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
    <Column x="4219" y="0" open="true" selected="false" sform="false" next="13" name="A" caption="split to left/right lung">
      <Subcolumn vislevel="3">
        <Row popup="false" name="A1">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="839" window_y="165" window_width="865" window_height="477" image_left="29301" image_top="200" image_mag="1" show_status="true" show_paintbox="false" show_convert="false" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="K25"/>
          </Rhs>
        </Row>
        <Row popup="false" name="A3">
          <Rhs vislevel="4" flags="7">
            <iImage window_x="2" window_y="56" window_width="750" window_height="295" image_left="360" image_top="102" image_mag="1" show_status="true" show_paintbox="false" show_convert="false" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="2">
              <Row name="super">
                <Rhs vislevel="0" flags="4">
                  <iImage image_left="0" image_top="0" image_mag="0" show_status="false" show_paintbox="false" show_convert="false" show_rulers="false" scale="0" offset="0" falsecolour="false" type="true"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="nwidth">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Image width (pixels)"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="A1.width"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="nheight">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Image height (pixels)"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="A1.height"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
            </Subcolumn>
            <iText formula="Pattern_images_item.Xy_item.action"/>
          </Rhs>
        </Row>
        <Row popup="false" name="A4">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="289" window_y="371" window_width="913" window_height="670" image_left="449" image_top="289" image_mag="1" show_status="true" show_paintbox="false" show_convert="false" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="(A3?0 % A1.height) &gt; A1.height / 2"/>
          </Rhs>
        </Row>
        <Row popup="false" name="A5">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="0" window_y="27" window_width="750" window_height="551" image_left="18665" image_top="275" image_mag="1" show_status="true" show_paintbox="false" show_convert="false" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="A1 &amp; A4"/>
          </Rhs>
        </Row>
        <Row popup="false" name="A6">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="1" window_y="28" window_width="750" window_height="551" image_left="14755" image_top="224" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="A1 &amp; !A4"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
    <Column x="2995" y="0" open="true" selected="false" sform="false" next="10" name="D" caption="draw ROIs">
      <Subcolumn vislevel="3">
        <Row popup="false" name="D2">
          <Rhs vislevel="0" flags="4">
            <iImage window_x="1006" window_y="159" window_width="750" window_height="551" image_left="368" image_top="219" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="106.98145070677305" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="image.output14"/>
          </Rhs>
        </Row>
        <Row popup="false" name="D1">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="0" window_y="6" window_width="750" window_height="551" image_left="5292" image_top="211" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="K25"/>
          </Rhs>
        </Row>
        <Row popup="false" name="D3">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="1102" window_y="337" window_width="750" window_height="551" image_left="1296" image_top="219" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="1.0602668167995037" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="(unsigned char) (D2 * 100)"/>
          </Rhs>
        </Row>
        <Row popup="false" name="D4">
          <Rhs vislevel="3" flags="7">
            <iImage image_left="0" image_top="0" image_mag="0" show_status="false" show_paintbox="false" show_convert="false" show_rulers="false" scale="0" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="1">
              <Row name="x">
                <Rhs vislevel="3" flags="4">
                  <iText/>
                </Rhs>
              </Row>
              <Row name="super">
                <Rhs vislevel="0" flags="4">
                  <iImage image_left="0" image_top="0" image_mag="0" show_status="false" show_paintbox="false" show_convert="false" show_rulers="false" scale="0" offset="0" falsecolour="false" type="true"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="mask">
                <Rhs vislevel="1" flags="1">
                  <Matrix/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="type">
                <Rhs vislevel="1" flags="1">
                  <Option caption="Operation" labelsn="2" labels0="Erode" labels1="Dilate" value="0"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="apply">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Number of times to apply mask"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="3"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
            </Subcolumn>
            <iText formula="Filter_morphology_item.Custom_morph_item.action D1"/>
          </Rhs>
        </Row>
        <Row popup="false" name="D5">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="0" window_y="6" window_width="750" window_height="551" image_left="1740" image_top="301" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="D4 ^ D1"/>
          </Rhs>
        </Row>
        <Row popup="false" name="D6">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="964" window_y="462" window_width="750" window_height="551" image_left="134155" image_top="219" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="if D5 then Vector [0,255,0] else D3 ++ D3 ++ D3"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
    <Column x="467" y="0" open="true" selected="false" sform="false" next="14" name="E" caption="make lung mask">
      <Subcolumn vislevel="3">
        <Row popup="false" name="E1">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="1029" window_y="247" window_width="750" window_height="800" image_left="17745" image_top="336" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="124.88767225714112" offset="2.5822782912562592" falsecolour="true" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="image.output14"/>
          </Rhs>
        </Row>
        <Row popup="false" name="E2">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="85" window_y="180" window_width="884" window_height="688" image_left="436" image_top="298" image_mag="1" show_status="true" show_paintbox="false" show_convert="false" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="E1 &lt; C6"/>
          </Rhs>
        </Row>
        <Row popup="false" name="E12">
          <Rhs vislevel="3" flags="7">
            <iImage window_x="325" window_y="278" window_width="750" window_height="551" image_left="6975" image_top="275" image_mag="1" show_status="true" show_paintbox="false" show_convert="false" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="1">
              <Row name="x">
                <Rhs vislevel="0" flags="4">
                  <iText/>
                </Rhs>
              </Row>
              <Row name="super">
                <Rhs vislevel="0" flags="4">
                  <iImage image_left="0" image_top="0" image_mag="0" show_status="false" show_paintbox="false" show_convert="false" show_rulers="false" scale="0" offset="0" falsecolour="false" type="true"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="rx">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Left"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="0"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="ry">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Top"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="0"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="rw">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Width"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="E2.width"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="rh">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Height"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="E2.height"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="f">
                <Rhs vislevel="1" flags="1">
                  <Toggle caption="Fill" value="false"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="t">
                <Rhs vislevel="1" flags="1">
                  <Slider/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="i">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Ink"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="[255]"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
            </Subcolumn>
            <iText formula="Image_draw_item.Rect_item.action E2"/>
          </Rhs>
        </Row>
        <Row popup="false" name="E11">
          <Rhs vislevel="3" flags="7">
            <iImage window_x="301" window_y="122" window_width="750" window_height="551" image_left="368" image_top="237" image_mag="1" show_status="true" show_paintbox="false" show_convert="false" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="1">
              <Row name="x">
                <Rhs vislevel="0" flags="4">
                  <iText/>
                </Rhs>
              </Row>
              <Row name="super">
                <Rhs vislevel="0" flags="4">
                  <iImage image_left="0" image_top="0" image_mag="0" show_status="false" show_paintbox="false" show_convert="false" show_rulers="false" scale="0" offset="0" falsecolour="false" type="true"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="sx">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Start x"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="0"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="sy">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Start y"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="0"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="e">
                <Rhs vislevel="1" flags="1">
                  <Option caption="Flood while" labelsn="2" labels0="Not equal to ink" labels1="Equal to start point" value="1"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="i">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Ink"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="[0]"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
            </Subcolumn>
            <iText formula="Image_draw_item.Flood_item.action E12"/>
          </Rhs>
        </Row>
        <Row popup="false" name="E13">
          <Rhs vislevel="3" flags="7">
            <iImage window_x="755" window_y="276" window_width="750" window_height="551" image_left="82447" image_top="275" image_mag="1" show_status="true" show_paintbox="false" show_convert="false" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="1">
              <Row name="x">
                <Rhs vislevel="3" flags="4">
                  <iText/>
                </Rhs>
              </Row>
              <Row name="super">
                <Rhs vislevel="0" flags="4">
                  <iImage image_left="0" image_top="0" image_mag="0" show_status="false" show_paintbox="false" show_convert="false" show_rulers="false" scale="0" offset="0" falsecolour="false" type="true"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="rx">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Left"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="0"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="ry">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Top"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="marklung.output3"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="rw">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Width"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="E11.width"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="rh">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Height"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="E11.height - marklung.output3"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="f">
                <Rhs vislevel="1" flags="1">
                  <Toggle/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="t">
                <Rhs vislevel="1" flags="1">
                  <Slider/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="i">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Ink"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
            </Subcolumn>
            <iText formula="Image_draw_item.Rect_item.action E11"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
    <Column x="874" y="0" open="true" selected="false" sform="false" next="5" name="G" caption="fill internal voids, clean up">
      <Subcolumn vislevel="3">
        <Row popup="false" name="G1">
          <Rhs vislevel="1" flags="1">
            <iImage window_x="0" window_y="618" window_width="750" window_height="551" image_left="368" image_top="237" image_mag="1" show_status="true" show_paintbox="false" show_convert="false" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="E13"/>
          </Rhs>
        </Row>
        <Row popup="false" name="G2">
          <Rhs vislevel="3" flags="7">
            <iImage window_x="895" window_y="410" window_width="750" window_height="551" image_left="305" image_top="312" image_mag="4" show_status="true" show_paintbox="false" show_convert="false" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="1">
              <Row name="x">
                <Rhs vislevel="3" flags="4">
                  <iText/>
                </Rhs>
              </Row>
              <Row name="super">
                <Rhs vislevel="0" flags="4">
                  <iImage image_left="0" image_top="0" image_mag="0" show_status="false" show_paintbox="false" show_convert="false" show_rulers="false" scale="0" offset="0" falsecolour="false" type="true"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="sx">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Start x"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="0"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="sy">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Start y"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="0"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="e">
                <Rhs vislevel="1" flags="1">
                  <Option caption="Flood while" labelsn="2" labels0="Not equal to ink" labels1="Equal to start point" value="1"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="i">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Ink"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="[128]"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
            </Subcolumn>
            <iText formula="Image_draw_item.Flood_item.action G1"/>
          </Rhs>
        </Row>
        <Row popup="false" name="G3">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="578" window_y="447" window_width="750" window_height="551" image_left="51832" image_top="237" image_mag="1" show_status="true" show_paintbox="false" show_convert="false" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="G2 != 128"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
    <Column x="2200" y="0" open="true" selected="false" sform="false" next="35" name="K" caption="remove trachea">
      <Subcolumn vislevel="3">
        <Row popup="false" name="K1">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="333" window_y="321" window_width="750" window_height="551" image_left="32624" image_top="266" image_mag="1" show_status="true" show_paintbox="false" show_convert="false" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="L2"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K2">
          <Rhs vislevel="3" flags="7">
            <Group/>
            <Subcolumn vislevel="1">
              <Row name="x">
                <Rhs vislevel="3" flags="4">
                  <iText/>
                </Rhs>
              </Row>
              <Row name="super">
                <Rhs vislevel="0" flags="4">
                  <Group/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="tile_width">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Tile width"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="K1.height"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="tile_height">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Tile height"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="K1.height"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="hoverlap">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Horizontal overlap"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="voverlap">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Vertical overlap"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
            </Subcolumn>
            <iText formula="Image_tile_item.Chop_item.action K1"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K3">
          <Rhs vislevel="2" flags="5">
            <Group/>
            <Subcolumn vislevel="0"/>
            <iText formula="K2.value?0"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K4">
          <Rhs vislevel="3" flags="7">
            <Group/>
            <Subcolumn vislevel="1"/>
            <iText formula="Image_select_item.Segment_item.action K3"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K5">
          <Rhs vislevel="1" flags="1">
            <Group/>
            <Subcolumn vislevel="0"/>
            <iText formula="Image_number_format_item.U8_item.action K4"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K6">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="141" window_y="111" window_width="526" window_height="551" image_left="256" image_top="267" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="83.607191973196549" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="K5.value?33"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K7">
          <Rhs vislevel="2" flags="5">
            <Subcolumn vislevel="0"/>
            <iText formula="Hist_find_item.Oned_item.action K5"/>
            <Group/>
          </Rhs>
        </Row>
        <Row popup="false" name="K14">
          <Rhs vislevel="2" flags="5">
            <iText formula="Group (map to_matrix K7.value)"/>
            <Group/>
            <Subcolumn vislevel="0"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K18">
          <Rhs vislevel="2" flags="5">
            <Group/>
            <Subcolumn vislevel="0"/>
            <iText formula="Group (map (\l take 10 (l.value?0)) K14.value)"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K19">
          <Rhs vislevel="2" flags="5">
            <Group/>
            <Subcolumn vislevel="0"/>
            <iText formula="Group (map (zip2 [0..]) K18.value)"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K20">
          <Rhs vislevel="2" flags="5">
            <Group/>
            <Subcolumn vislevel="0"/>
            <iText formula="Group (map (sortc (\a\b a?1 &gt; b?1)) K19.value)"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K21">
          <Rhs vislevel="2" flags="5">
            <Group/>
            <Subcolumn vislevel="0"/>
            <iText formula="Group (map (\l [l?1?0, l?2?0]) K20.value)"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K22">
          <Rhs vislevel="2" flags="5">
            <Group/>
            <Subcolumn vislevel="0"/>
            <iText formula="Group (map2 (\i\v i == v?0 | i == v?1) K5.value K21.value)"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K24">
          <Rhs vislevel="1" flags="4">
            <iText formula="[K22.value]"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K27">
          <Rhs vislevel="1" flags="4">
            <iText formula="map (get_member &quot;value&quot;) (foldr1 concat K24)"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K32">
          <Rhs vislevel="1" flags="4">
            <iText formula="vips_call &quot;arrayjoin&quot; [K27] []"/>
          </Rhs>
        </Row>
        <Row popup="false" name="K25">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="193" window_y="242" window_width="750" window_height="551" image_left="38409" image_top="219" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="Image K32?0"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
    <Column x="1746" y="0" open="true" selected="false" sform="false" next="3" name="L" caption="erode">
      <Subcolumn vislevel="3">
        <Row popup="false" name="L1">
          <Rhs vislevel="0" flags="4">
            <iImage image_left="0" image_top="0" image_mag="0" show_status="false" show_paintbox="false" show_convert="false" show_rulers="false" scale="0" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="DB10"/>
          </Rhs>
        </Row>
        <Row popup="false" name="L2">
          <Rhs vislevel="3" flags="7">
            <iImage image_left="0" image_top="0" image_mag="0" show_status="false" show_paintbox="false" show_convert="false" show_rulers="false" scale="0" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="1">
              <Row name="x">
                <Rhs vislevel="3" flags="4">
                  <iText/>
                </Rhs>
              </Row>
              <Row name="super">
                <Rhs vislevel="0" flags="4">
                  <iImage image_left="0" image_top="0" image_mag="0" show_status="false" show_paintbox="false" show_convert="false" show_rulers="false" scale="0" offset="0" falsecolour="false" type="true"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="mask">
                <Rhs vislevel="1" flags="1">
                  <Matrix/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="type">
                <Rhs vislevel="1" flags="1">
                  <Option caption="Operation" labelsn="2" labels0="Erode" labels1="Dilate" value="0"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="apply">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Number of times to apply mask"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="marklung.output5"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
            </Subcolumn>
            <iText formula="Filter_morphology_item.Custom_morph_item.action L1"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
    <Column x="0" y="0" open="true" selected="false" sform="false" next="7" name="C" caption="check lung density">
      <Subcolumn vislevel="3">
        <Row popup="false" name="C1">
          <Rhs vislevel="2" flags="5">
            <iImage window_x="442" window_y="244" window_width="750" window_height="551" image_left="83072" image_top="402" image_mag="-2" show_status="true" show_paintbox="false" show_convert="true" show_rulers="true" scale="233.51258149728764" offset="0" falsecolour="true" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="image.output14"/>
          </Rhs>
        </Row>
        <Row popup="false" name="C2">
          <Rhs vislevel="1" flags="1">
            <iRegion window_x="29" window_y="29" window_width="632" window_height="178" image_left="300" image_top="21" image_mag="1" show_status="true" show_paintbox="false" show_convert="true" show_rulers="true" scale="1" offset="0" falsecolour="false" type="true" left="83086" top="136" width="22" height="21">
              <iRegiongroup/>
            </iRegion>
            <Subcolumn vislevel="0"/>
            <iText formula="Region C1 17585 324 21 28"/>
          </Rhs>
        </Row>
        <Row popup="false" name="C3">
          <Rhs vislevel="1" flags="4">
            <iText formula="Math_stats_item.Mean_item.action C2"/>
          </Rhs>
        </Row>
        <Row popup="false" name="C4">
          <Rhs vislevel="1" flags="4">
            <iText formula="&quot; &quot;"/>
          </Rhs>
        </Row>
        <Row popup="false" name="C5">
          <Rhs vislevel="1" flags="4">
            <iText formula="&quot;density threshold&quot;"/>
          </Rhs>
        </Row>
        <Row popup="false" name="C6">
          <Rhs vislevel="1" flags="4">
            <iText formula="0.8"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
    <Column x="3476" y="0" open="true" selected="true" sform="false" next="13" name="B" caption="arrange as a grid">
      <Subcolumn vislevel="3">
        <Row popup="false" name="B1">
          <Rhs vislevel="1" flags="1">
            <iImage image_left="0" image_top="0" image_mag="0" show_status="false" show_paintbox="false" show_convert="false" show_rulers="false" scale="0" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="0"/>
            <iText formula="D6"/>
          </Rhs>
        </Row>
        <Row popup="false" name="B3">
          <Rhs vislevel="1" flags="4">
            <iText formula="inputs.slices"/>
          </Rhs>
        </Row>
        <Row popup="false" name="B4">
          <Rhs vislevel="2" flags="4">
            <iText formula="B3 ** 0.5"/>
          </Rhs>
        </Row>
        <Row popup="false" name="B5">
          <Rhs vislevel="1" flags="4">
            <iText formula="(int) B4 + 1"/>
          </Rhs>
        </Row>
        <Row popup="false" name="B6">
          <Rhs vislevel="1" flags="4">
            <iText formula="B5 * inputs.A2.width"/>
          </Rhs>
        </Row>
        <Row popup="false" name="B2">
          <Rhs vislevel="3" flags="7">
            <Group/>
            <Subcolumn vislevel="1">
              <Row name="x">
                <Rhs vislevel="0" flags="4">
                  <iText/>
                </Rhs>
              </Row>
              <Row name="super">
                <Rhs vislevel="0" flags="4">
                  <Group/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="tile_width">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Tile width"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="B6"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="tile_height">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Tile height"/>
                  <Subcolumn vislevel="0">
                    <Row name="caption">
                      <Rhs vislevel="0" flags="4">
                        <iText/>
                      </Rhs>
                    </Row>
                    <Row name="expr">
                      <Rhs vislevel="0" flags="4">
                        <iText formula="inputs.A6"/>
                      </Rhs>
                    </Row>
                    <Row name="super">
                      <Rhs vislevel="1" flags="4">
                        <Subcolumn vislevel="0"/>
                        <iText/>
                      </Rhs>
                    </Row>
                  </Subcolumn>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="hoverlap">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Horizontal overlap"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
              <Row name="voverlap">
                <Rhs vislevel="1" flags="1">
                  <Expression caption="Vertical overlap"/>
                  <Subcolumn vislevel="0"/>
                  <iText/>
                </Rhs>
              </Row>
            </Subcolumn>
            <iText formula="Image_tile_item.Chop_item.action B1"/>
          </Rhs>
        </Row>
        <Row popup="false" name="B10">
          <Rhs vislevel="1" flags="1">
            <Group/>
            <Subcolumn vislevel="0"/>
            <iText formula="Object_group_to_list_item.action B2"/>
          </Rhs>
        </Row>
        <Row popup="false" name="B11">
          <Rhs vislevel="1" flags="4">
            <iText formula="Object_group_to_list_item.action B10"/>
          </Rhs>
        </Row>
        <Row popup="false" name="B12">
          <Rhs vislevel="1" flags="4">
            <iText formula="Matrix_transpose_item.action B11"/>
          </Rhs>
        </Row>
        <Row popup="false" name="B9">
          <Rhs vislevel="3" flags="7">
            <iImage window_x="29" window_y="29" window_width="750" window_height="750" image_left="5166" image_top="4438" image_mag="-14" show_status="true" show_paintbox="false" show_convert="true" show_rulers="false" scale="1" offset="0" falsecolour="false" type="true"/>
            <Subcolumn vislevel="1"/>
            <iText formula="Image_join_item.Array_item.action B12"/>
          </Rhs>
        </Row>
      </Subcolumn>
    </Column>
  </Workspace>
</root>
