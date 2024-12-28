state("gravitybone", "KMQuake2")
{
   //pointers
    string7 state_name: "gravitybone.exe", 0xA58D14; 
    int birds : 0x00221AC, 0x10C;
    bool inMenu: "gravitybone.exe", 0x1B1EA8;
    bool isNotLoading: "gravitybone.exe", 0x14B690C; 
    int elevator : "gravitybone.exe", 0x9F6540;
    bool fine: "gravitybone.exe", 0x10C69C; 
    int friendly_mutton_chop : 0x0019504, 0x75C;
    

}
init 
{
   vars.split = 0;

}
update
{
    if ( current.state_name == "parlo1" );
    {
        vars.split = 0;
    }

}
startup 
{

    settings.Add("option1", true ,"Friendly Mutton Chop Finish Split");
    settings.Add("option2", true ,"Bird's Photo Split");
    settings.Add("option3", true ,"1st Bird's Photo Split","option2");
    settings.Add("option4", true ,"2nd Bird's Photo Split","option2");   
    settings.Add("option5", true ,"3rd Bird's Photo Split","option2");
    settings.Add("option6", true ,"4th Bird's Photo Split","option2");
    settings.Add("option7", true ,"5th Bird's Photo Split","option2");
    settings.Add("option8", true ,"Elevator Split");

    settings.SetToolTip("option1", "First Level Ending Split" );
    settings.SetToolTip("option2", "Splitting for every Bird Photo" );
    settings.SetToolTip("option8", "Splitting at the Elevator" );
   
   
}
start 
{
    if ( current.friendly_mutton_chop != 0 && old.friendly_mutton_chop == 0 && current.state_name == "parlo1" )
    {
        vars.split++;
        return true;
    }

}


split
{
    if (settings ["option1"])
    {
        if( current.state_name == "b01.cin" && old.state_name == "parlo1"  )    //friendly muttond chop's end split
        {
            vars.split+=1;
            return true;
        }
    }
    if (settings ["option3"] && settings ["option2"] )
    {
        if( current.birds == 327681 && old.birds == 0 )  //bird 1 
        {
            vars.split+=1;
            return true;
        }
    }
    if (settings ["option4"] && settings ["option2"])
    {
        if( current.birds == 327682 && old.birds == 327681 )   //bird 2
        {
            vars.split+=1;
            return true;
        }
    }
    if (settings ["option5"] && settings ["option2"])
    {
        if( current.birds == 327683 && old.birds == 327682 )   //bird 3
        {
            vars.split+=1;
            return true;
        }
    }
    if (settings ["option6"] && settings ["option2"])
    {
        if( current.birds == 327684 && old.birds == 327683 )   //bird 4
        {
            vars.split+=1;
            return true;
        }
    }
    if (settings ["option7"] && settings ["option2"])
    {
        if( current.birds == 327685 && old.birds == 327684 )   //bird 5
        {
            vars.split+=1;
            return true;
        }
    }
      
    if (settings ["option8"] )
    {
        if( current.elevator == 0 && old.elevator != 0 && current.state_name == "hof1" && current.birds == 327685 )    //elevator split
        {
            vars.split+=1;
            return true;
        }
    }
    
    if( current.fine == false  && old.fine != false && current.state_name == "hof1" && current.isNotLoading == true )    //ending split
    {
        vars.split+=1;
        return true;
    }
    
    
    
}

isLoading
{
    if (current.isNotLoading == false || current.inMenu == true)
    {
        return true;
    }
    else 
        return false;
        
        
}

reset
{
    if ( current.friendly_mutton_chop == 0 && old.friendly_mutton_chop != 0 && current.state_name != "b01.cin" && current.state_name != "victory.p" && current.state_name != "hof1" )
    {
        vars.split=0;
        return true;
    }


}
