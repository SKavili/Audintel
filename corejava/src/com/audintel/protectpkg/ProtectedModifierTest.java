package com.audintel.protectpkg;

import com.audintel.accessmodifer.AccessModifier;

public class ProtectedModifierTest extends AccessModifier{


    public static void main(String[] args) {

        AccessModifier    am = new AccessModifier();
        System.out.println(am.strPublic);

        ProtectedModifierTest    pmt = new ProtectedModifierTest();
        System.out.println(pmt.strPublic);
        System.out.println(pmt.strProtected);

    }
}