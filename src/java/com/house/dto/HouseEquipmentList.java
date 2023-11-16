package com.house.dto;

public class HouseEquipmentList {
    private Integer houseType1;
    private Integer houseType2;
    private Integer houseType3;
    private Integer houseType4;
    private Integer houseType5;
    private Integer houseType6;
    private Integer houseType7;
    private Integer houseType8;
    private Integer houseType9;
    private Integer houseType10;
    private Integer houseType11;
    private Integer houseType12;
    private Integer houseType13;
    private Integer houseType14;

    public Integer getHouseType1() {
        return houseType1;
    }

    public void setHouseType1(Integer houseType1) {
        this.houseType1 = houseType1;
    }

    public Integer getHouseType2() {
        return houseType2;
    }

    public void setHouseType2(Integer houseType2) {
        this.houseType2 = houseType2;
    }

    public Integer getHouseType3() {
        return houseType3;
    }

    public void setHouseType3(Integer houseType3) {
        this.houseType3 = houseType3;
    }

    public Integer getHouseType4() {
        return houseType4;
    }

    public void setHouseType4(Integer houseType4) {
        this.houseType4 = houseType4;
    }

    public Integer getHouseType5() {
        return houseType5;
    }

    public void setHouseType5(Integer houseType5) {
        this.houseType5 = houseType5;
    }

    public Integer getHouseType6() {
        return houseType6;
    }

    public void setHouseType6(Integer houseType6) {
        this.houseType6 = houseType6;
    }

    public Integer getHouseType7() {
        return houseType7;
    }

    public void setHouseType7(Integer houseType7) {
        this.houseType7 = houseType7;
    }

    public Integer getHouseType8() {
        return houseType8;
    }

    public void setHouseType8(Integer houseType8) {
        this.houseType8 = houseType8;
    }

    public Integer getHouseType9() {
        return houseType9;
    }

    public void setHouseType9(Integer houseType9) {
        this.houseType9 = houseType9;
    }

    public Integer getHouseType10() {
        return houseType10;
    }

    public void setHouseType10(Integer houseType10) {
        this.houseType10 = houseType10;
    }

    public Integer getHouseType11() {
        return houseType11;
    }

    public void setHouseType11(Integer houseType11) {
        this.houseType11 = houseType11;
    }

    public Integer getHouseType12() {
        return houseType12;
    }

    public void setHouseType12(Integer houseType12) {
        this.houseType12 = houseType12;
    }

    public Integer getHouseType13() {
        return houseType13;
    }

    public void setHouseType13(Integer houseType13) {
        this.houseType13 = houseType13;
    }

    public Integer getHouseType14() {
        return houseType14;
    }

    public void setHouseType14(Integer houseType14) {
        this.houseType14 = houseType14;
    }


    public static Integer[] getString(HouseEquipmentList houseEquipmentList){
        Integer[] str=new Integer[14];
        if(houseEquipmentList.getHouseType1()!=null){
            str[0]= houseEquipmentList.getHouseType1();
        }
        if(houseEquipmentList.getHouseType2()!=null){
            str[1]= houseEquipmentList.getHouseType2();
        }
        if(houseEquipmentList.getHouseType3()!=null){
            str[2]= houseEquipmentList.getHouseType3();
        }
        if(houseEquipmentList.getHouseType4()!=null){
            str[3]= houseEquipmentList.getHouseType4();
        }
        if(houseEquipmentList.getHouseType5()!=null){
            str[4]= houseEquipmentList.getHouseType5();
        }
        if(houseEquipmentList.getHouseType6()!=null){
            str[5]= houseEquipmentList.getHouseType6();
        }
        if(houseEquipmentList.getHouseType7()!=null){
            str[6]= houseEquipmentList.getHouseType7();
        }
        if(houseEquipmentList.getHouseType8()!=null){
            str[7]= houseEquipmentList.getHouseType8();
        }
        if(houseEquipmentList.getHouseType9()!=null){
            str[8]= houseEquipmentList.getHouseType9();
        }
        if(houseEquipmentList.getHouseType10()!=null){
            str[9]= houseEquipmentList.getHouseType10();
        }
        if(houseEquipmentList.getHouseType11()!=null){
            str[10]= houseEquipmentList.getHouseType11();
        }
        if(houseEquipmentList.getHouseType12()!=null){
            str[11]= houseEquipmentList.getHouseType12();
        }
        if(houseEquipmentList.getHouseType13()!=null){
            str[12]= houseEquipmentList.getHouseType13();
        }
        if(houseEquipmentList.getHouseType14()!=null){
            str[13]= houseEquipmentList.getHouseType14();
        }
        return str;
    }


}
