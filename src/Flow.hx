import haxe.io.Path;


//Flow haxelib run script
// - Forwards commands directly to node.js script shown below

class Flow {

    public static var run_path : String = './';
    public static var flow_path : String = './';
    public static var node_path : String = 'bin/node';
    public static var node_script : String = 'src/flow/flow.js';
    public static var system : String = 'none';

    static function main() {

        var sys_args = Sys.args();

        flow_path = Sys.getCwd();
        run_path = sys_args.pop();

        system = get_platform();

            //append the system name and infp
        node_path = Path.normalize(Path.join([flow_path,node_path]));
        node_path += '-$system';

        //we do `node script.js run_path system <other>`

            //the second argument to flow.js is system
        sys_args.unshift(system);
            //the first argument to flow.js is run_path
        sys_args.unshift(run_path);
            //then give node the script name
        sys_args.unshift(node_script);

            //run it
        Sys.command(node_path, sys_args);

    } //main

    static function get_platform() : String {
        return Sys.systemName().toLowerCase();
    }

} //Flow