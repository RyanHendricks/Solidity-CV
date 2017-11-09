/**           |
*           \ | /
*         -=- 0 -=-    ryanhendricks@gmail.com
*           / | \                          _\/_
*             |                            //☯\  _\/_
*   _  ___ ___  _ __ __ _  _ _  _ _ __  __ _ | __/☯\\ _
* .-"-._.-"-._.-.-"-._.-"-._.-.-"-._.-"-._,-'|"'""-|-,_
* -"-._.-"-._.-"-._.-.-"-._.-"-._.-.-"-~/          |
* _.-"-._.-"-._.-"-._.-.-"-._.-"-._.-""/           jgs */
/// @title Curriculum Vitae
/// @author Ryan Hendricks

pragma solidity ^0.4.16;


library Structures {

    struct BasicInfo {
        string _name;           /// Name; First & Last
        string _label;          /// Job Title 
        string _email;          /// Email Address
        string _phone;          /// Phone Number
        string _website;        /// Website URL
        string _summary;        /// Executive Summary
        string _location;       /// Description
    }

    struct Profile {
        string _network;        /// Name of network
        string _username;       /// Account username
        string _url;            /// URL of profile
    }

    /// @dev Can be used for both Work and Volunteer
    struct Position {
        string _company;        /// Name of Company
        string _position;       /// Position at Company
        string _website;        /// Website of Company
        string _startDate;      /// Start Date
        string _endDate;        /// End Date (blank if ongoing)
        string _summary;        /// Summary of position
        string _highlights;     /// Notable Accomplishments
    }

    struct Education {
        string _institution;    /// Name of School
        string _degree;         /// Degree
        string _focusArea;      /// Major and/or Minor
        string _yearStart;       /// Year started degree
        string _yearFinish;      /// Graduation year
    }

    struct Project {
        string _name;            /// Name of project
        string _link;            /// Link to project website
        string _description;     /// Description of project
    }

    struct Publication {
        string _title;           /// Title of Publication
        string _publisher;       /// Publisher or Medium of Pub.
        string _date;            /// Date of Publication
        string _link;            /// URL of Publication
        string _description;     /// Summary or Abstract
    }

    struct Skill {
        string _name;            /// Skill name
        int32 _level;            /// Skill level 1-10
    }

    struct Language {
        string _language;        /// Name of Language
        string _fluency;         /// Language proficiency
    }
}


contract CV {
    
    address public owner;

    Structures.BasicInfo[] public basics;
    Structures.Profile[] public profiles;
    Structures.Position[] public positions;
    Structures.Education[] public education;
    Structures.Project[] public projects;
    Structures.Publication[] public publications;
    Structures.Skill[] public skills;
    Structures.Language[] public languages;

    function CV() {
        owner = msg.sender;
    }

    /// @dev only the contract owner can modify
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    /// @dev allows contract to be destroyed by owner
    function kill() public {
        if (msg.sender == owner)
            selfdestruct(owner);
    }




    /// Functions for modifying CV data

    function editBasics (
        bool operation,
        string name,
        string label,
        string email,
        string phone,
        string website,
        string summary,
        string location
        ) public onlyOwner()
        {
                if (operation) { basics.push(Structures.BasicInfo(
                name,
                label,
                email,
                phone,
                website,
                summary,
                location));
                } else {
                    delete basics[basics.length - 1];
                }
            }
    
    function editProfiles (
        bool operation,
        string network,
        string username,
        string url
        ) public onlyOwner()
        {if (operation) {profiles.push(Structures.Profile(
            network,
            username,
            url));
            } else {
                delete profiles[profiles.length - 1];
            }
        }

    function editPositions (
        bool operation,
        string company,
        string position,
        string website,
        string startDate,
        string endDate,
        string summary,
        string highlights     /// Notable Accomplishments
        ) public onlyOwner()
        { if (operation) {positions.push(Structures.Position(
            company,
            position,
            website,
            startDate,
            endDate,
            summary,
            highlights));
            } else {
                delete positions[positions.length - 1];
            }
        }


    function editEducation (
        bool operation,
        string institution,
        string degree,
        string focusArea,
        string yearStart,
        string yearFinish
        ) public onlyOwner()
        {
            if (operation) { 
                education.push(Structures.Education(
            institution,
            degree,
            focusArea,
            yearStart,
            yearFinish));
            } else {
                delete education[education.length - 1];
            }
        }

    /**
     * @dev edit projects
     * @param operation bool used to indicate if data is being added or deleted
     * @param name is the name of the project
     * @param link is the URL of the project
     * @param description is a free response decription of the project
     */
    function editProject (
        bool operation,
        string name,
        string link,
        string description
        ) public onlyOwner() 
        {
            if (operation) {
                projects.push(Structures.Project(name, link, description));
            } else {
                delete projects[projects.length - 1];
            }
        }

    function editPublication (
        bool operation,
        string title,
        string publisher,
        string date,
        string link,
        string description
        ) public onlyOwner()
        {
            if (operation) {
                publications.push(
            Structures.Publication(
                title,
                publisher,
                date,
                link,
                description));
            } else {
                delete publications[publications.length - 1];
            }
        }

    function editSkill(bool operation, string name, int32 level) public onlyOwner() {
        if (operation) {
            skills.push(Structures.Skill(name, level));
        } else {
            delete skills[skills.length - 1];
        }
    }


    function editLanguage(bool operation, string language, string fluency) public onlyOwner() {
        if (operation) {
            languages.push(Structures.Language(language, fluency));
        } else {
            delete languages[languages.length - 1];
        }
    }


    function getSize(string arg) public constant returns (uint) {
        if (keccak256(arg) == keccak256("projects")) {return projects.length;}
        if (keccak256(arg) == keccak256("education")) {return education.length;}
        if (keccak256(arg) == keccak256("publications")) {return publications.length;}
        if (keccak256(arg) == keccak256("skills")) {return skills.length;}
        if (keccak256(arg) == keccak256("languages")) {return languages.length;}
        if (keccak256(arg) == keccak256("positions")) {return positions.length;}
        revert();
    }
}