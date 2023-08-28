# Test simple jump

(official doc)

Godot offers four kinds of collision objects which all extend CollisionObject2D. 
The last three listed below are physics bodies and additionally extend PhysicsBody2D.

    Area2D

        Area2D nodes provide detection and influence. They can detect when objects overlap and can emit signals when bodies enter or exit. An Area2D can also be used to override physics properties, such as gravity or damping, in a defined area.

    StaticBody2D

        A static body is one that is not moved by the physics engine. It participates in collision detection, but does not move in response to the collision. They are most often used for objects that are part of the environment or that do not need to have any dynamic behavior.

    RigidBody2D

        This is the node that implements simulated 2D physics. You do not control a RigidBody2D directly, but instead you apply forces to it (gravity, impulses, etc.) and the physics engine calculates the resulting movement. Read more about using rigid bodies.

    CharacterBody2D

        A body that provides collision detection, but no physics. All movement and collision response must be implemented in code.


Note about Kinematic engine

    Yes, the name sounds strange. "Kinematic Character". What is that? The reason for the name is that, when physics engines came out, they were called "Dynamics" engines (because they dealt mainly with collision responses). Many attempts were made to create a character controller using the dynamics engines, but it wasn't as easy as it seemed. Godot has one of the best implementations of dynamic character controller you can find (as it can be seen in the 2d/platformer demo), but using it requires a considerable level of skill and understanding of physics engines (or a lot of patience with trial and error).

    Some physics engines, such as Havok seem to swear by dynamic character controllers as the best option, while others (PhysX) would rather promote the kinematic one.

    So, what is the difference?:

        A dynamic character controller uses a rigid body with an infinite inertia tensor. It's a rigid body that can't rotate. Physics engines always let objects move and collide, then solve their collisions all together. This makes dynamic character controllers able to interact with other physics objects seamlessly, as seen in the platformer demo. However, these interactions are not always predictable. Collisions can take more than one frame to be solved, so a few collisions may seem to displace a tiny bit. Those problems can be fixed, but require a certain amount of skill.

        A kinematic character controller is assumed to always begin in a non-colliding state, and will always move to a non-colliding state. If it starts in a colliding state, it will try to free itself like rigid bodies do, but this is the exception, not the rule. This makes their control and motion a lot more predictable and easier to program. However, as a downside, they can't directly interact with other physics objects, unless done by hand in code.


## Objects used

This demo implements kinematic character engine.

CharacterBody2D :

    is a specialized class for physics bodies that are meant to be user-controlled. They are not affected by physics at all, but they affect other physics bodies in their path.

    They are mainly used to provide high-level API to move objects with wall and slope detection (move_and_slide method) in addition to the general collision detection provided by PhysicsBody2D.move_and_collide. 
    
    This makes it useful for highly configurable physics bodies that must move in specific ways and collide with the world, as is often the case with user-controlled characters.

TileMap :

    Node for 2D tile-based maps. Tilemaps use a TileSet which contain a list of tiles which are used to create grid-based maps. A TileMap may have several layers, layouting tiles on top of each other.

## Physics

Some physics properties and behaviors (linked to Object 2D) precisions:

    CharacterBody2D when is falling, hits the ground (TileMap), and is blocked

    The collision with other Bodies is not automatically managed ==> means you have to set collision shape and emit or read signals
    
    The dynamic properties (like velocity, direction / rotation) are not fully managed ==> means you have to set properties velocity, the engine moves only the object

Other points, collision in the path of CharacterBody2D :

    The physics engine can't handle scale on most types of shapes (only collision polygons, planes and segments work), so always change the parameters (such as radius) of the shape instead of scaling it. The same is also true for the kinematic/rigid/static bodies themselves, as their scale affects the shape scale.
