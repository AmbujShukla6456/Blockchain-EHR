// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract admin{

    struct patient{
        string name;
        address add;
        uint age;
        string gender;
        string contact;
        string symptoms;
        string need;
        string assigned;
        uint id;
        string prescription;
    }

    struct doctor{
        address add;
        uint id;
        uint[] patients;
        string specilization;
        string name;
    }

    doctor[] public Doctors;
    patient[] public Patients;

    uint patient_count=0;
    uint doctor_count=0;

    function addPatient(string memory _name,address _add,uint _age, string memory _gender, string memory _symptoms,string memory _need, string memory _phone) payable public {    
        patient memory newp;
        newp.name=_name;
        newp.add=_add;
        newp.age=_age;
        newp.gender=_gender;
        newp.symptoms=_symptoms;
        newp.need=_need;
        newp.contact=_phone;
        newp.assigned="";
        newp.id=patient_count+1;
        newp.prescription="none";
        Patients.push(newp);
        patient_count++;
    }

    function addDoctor(address _add,uint[] memory _patients,string memory _speciality,string memory _name) payable public{
        doctor memory newd;
        newd.name=_name;
        newd.specilization=_speciality;
        newd.patients=_patients;
        newd.add=_add;
        newd.id=doctor_count+1;
        doctor_count++;
        Doctors.push(newd);
    }

    function checkUp(uint _id, string memory _new) payable public{
        uint i=0;
        while(i<patient_count)
        {
            if(Patients[i].id==_id)
                break;
            i++;
        }
        Patients[i].symptoms=_new;
    }

    function prescribe(uint _id,string memory pres) payable public{
        uint i=0;
        while(i<patient_count)
        {
            if(Patients[i].id==_id)
                break;
            i++;
        }
        Patients[i].prescription=pres;
    }

    function assigned() payable public {
        uint i=0;
        while(i<patient_count)
        {
            for(uint j=0;j<doctor_count;j++)
            {
                if(keccak256(bytes(Patients[i].need))==keccak256(bytes(Doctors[j].specilization))){
                    Patients[i].assigned=Doctors[j].name;
                    Doctors[j].patients.push(Patients[i].id);
                }
            }
            i++;
        }
    }

    function doclog(address add,uint _id) view public returns(bool){
        for(uint i=0;i<doctor_count;i++)
        {
            if(Doctors[i].id==_id)
                if(Doctors[i].add==add)
                    return true;
            else
                return false;
        }
    }

    function patlog(address add,uint _id) view public returns(bool){
        for(uint i=0;i<doctor_count;i++)
        {
            if(Patients[i].id==_id)
                if(Patients[i].add==add)
                    return true;
            else
                return false;
        }
    }
    
    function getPatient(uint id) public view returns (string memory, uint, string memory,string memory,string memory) {
        patient memory p = Patients[id-1];
        return (p.name, p.age, p.symptoms,p.assigned,p.prescription);
    }
}