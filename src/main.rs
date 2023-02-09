use bevy::prelude::*;

fn main() {
    App::new()
    .add_startup_system(setup)
    .add_plugins(DefaultPlugins)
    .run();
}

fn setup(mut commands: Commands, asset_server: Res<AssetServer>){
    // Create camera
    commands.spawn(Camera2dBundle::default());

    // Add Sprites(?)

    commands.spawn(SpriteBundle{
        texture: asset_server.load("placeholder1.png"),
        ..default()
    });
}


#[derive(Resource, Default)]
struct GameState{
    fullness_level: u16,
    current_timer: f32,
    score_timer: f64,
    started: bool,
}

#[derive(Resource)]
struct GameRules{
    max_fullness: u16,
    starting_time: f32
}

#[derive(Resource, Default)]
struct Scores{
    best_score:f64,
    this_score:f64
}

fn new_game(game_rules: Res<GameRules>, mut game_state: ResMut<GameState>){
    game_state.fullness_level = 0;
    game_state.score_timer = 0; // seconds
    game_state.current_timer = game_rules.starting_time; // 30 seconds.
    game_state.started = false;
}

fn game_win_condition_check(
    game_rules: Res<GameRules>,
    mut game_state: ResMut<GameState>
){
    if (game_state.fullness_level >= game_rules.max_fullness){
            // Player wins here
    }
}