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

    /// @dev Used for both Work and Volunteer
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
        int32 _yearStart;       /// Year started degree
        int32 _yearFinish;      /// Graduation year
    }

    struct Project {
        string name;            /// Name of project
        string link;            /// Link to project website
        string description;     /// Description of project
    }

    struct Publication {
        string title;           /// Title of Publication
        string publisher;       /// Publisher or Medium of Pub.
        string date;            /// Date of Publication
        string link;            /// URL of Publication
        string description;     /// Summary or Abstract
    }

    struct Skill {
        string name;            /// Skill name
        int32 level;            /// Skill level 1-10
    }

    struct Languages {
        string language;        /// Name of Language
        string fluency;         /// Language proficiency
    }
}


contract Owned {

    address public owner;       /// Address of contract owner

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function owned() public {
        owner = msg.sender;
    }

    function kill() public {
        if (msg.sender == owner)
        selfdestruct(owner);
    }
}


contract SolidityCV is Owned {
    mapping (string => string) basics;
    
    /// @notice address of contract owner
    address public owner;

    /// @dev Mapping data into data structures 
    Structures.BasicInfo[] public basic;
    Structures.Profile[] public profiles;
    Structures.Position[] public positions;
    Structures.Education[] public education;
    Structures.Project[] public projects;
    Structures.Publication[] public publications;
    Structures.Skill[] public skills;
    Structures.Languages[] public languages;


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
            if (operation) { basics.push(Structures.Basics(
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
        {
        if (operation) {profiles.push(Structures.Profiles(
            operation,
            network,
            username,
            url));
            } else {
            delete profiles[profiles.length - 1];
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
        if (operation) { education.push(Structures.Education(
            institution,
            degree,
            focusArea,
            yearStart,
            yearFinish));
            } else {
            delete education[education.length - 1];
            }
        }

/// TODO FROM HERE DOWN
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

    function editEducation (
        bool operation,
        string _institution,
        string _focusArea,
        int32 _yearStart,
        int32 _yearFinish
    ) public onlyOwner()
    {
        if (operation) {
            education.push(
                Structures.Education(
                    _institution,
                    _focusArea,
                    _yearStart,
                    _yearFinish
                    )
            );
        } else {
            delete education[education.length - 1];
        }
    }

    function editSkill(bool operation, string name, int32 level) public onlyOwner() {
        if (operation) {
            skills.push(Structures.Skill(name, level));
        } else {
            delete skills[skills.length - 1];
            }
        }


    function editPublication (bool operation, string name, string link, string language) public onlyOwner() {
        if (operation) {
            publications.push(Structures.Publication(name, link, language));
        } else {
            delete publications[publications.length - 1];
        }
    }


    function getSize(string arg) public constant returns (uint) {
        if (keccak256(arg) == keccak256("projects")) {return projects.length;}
        if (keccak256(arg) == keccak256("education")) {return education.length;}
        if (keccak256(arg) == keccak256("publications")) {return publications.length;}
        if (keccak256(arg) == keccak256("skills")) {return skills.length;}
        revert();
    }
}