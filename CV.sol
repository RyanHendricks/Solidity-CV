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
        string name;           /// Name; First & Last
        string label;          /// Job Title 
        string email;          /// Email Address
        string phone;          /// Phone Number
        string website;        /// Website URL
        string summary;        /// Executive Summary
        string location;       /// Description
    }

    struct Profile {
        string network;        /// Name of network
        string username;       /// Account username
        string url;            /// URL of profile
    }

    /// @dev Can be used for both Work and Volunteer
    struct Position {
        string company;        /// Name of Company
        string position;       /// Position at Company
        string website;        /// Website of Company
        string startDate;      /// Start Date
        string endDate;        /// End Date (blank if ongoing)
        string summary;        /// Summary of position
        string highlights;     /// Notable Accomplishments
    }

    struct Education {
        string institution;    /// Name of School
        string degree;         /// Degree
        string focusArea;      /// Major and/or Minor
        string yearStart;       /// Year started degree
        string yearFinish;      /// Graduation year
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

    struct Language {
        string language;        /// Name of Language
        string fluency;         /// Language proficiency
    }
}


contract SolidityCV {
    
    /// @notice address of contract owner
    address public owner;

    function SolidityCV() {
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

    /// @dev Mapping data into data structures 
    Structures.BasicInfo[] public basics;
    Structures.Profile[] public profiles;
    Structures.Position[] public positions;
    Structures.Education[] public education;
    Structures.Project[] public projects;
    Structures.Publication[] public publications;
    Structures.Skill[] public skills;
    Structures.Language[] public languages;


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
        {
        if (operation) {profiles.push(Structures.Profile(
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
        {
        if (operation) {positions.push(Structures.Position(
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

    /// @dev function to obtain the number of items in a category
    /// @param string representing name of category
    /// @return the number of items in category
    function getSize(string arg) public constant returns (uint) {
        if (keccak256(arg) == keccak256("projects")) {return projects.length;}
        if (keccak256(arg) == keccak256("education")) {return education.length;}
        if (keccak256(arg) == keccak256("publications")) {return publications.length;}
        if (keccak256(arg) == keccak256("skills")) {return skills.length;}
        if (keccak256(arg) == keccak256("languages")) {return skills.length;}
        if (keccak256(arg) == keccak256("positions")) {return skills.length;}
        revert();
    }
}