def compute_hog_feature_size(image_shape, orientations, pixels_per_cell, cells_per_block):
    height, width = image_shape, image_shape
    num_cells_x = width // pixels_per_cell
    num_cells_y = height // pixels_per_cell
    num_blocks_x = num_cells_x - cells_per_block + 1
    num_blocks_y = num_cells_y - cells_per_block + 1
    features_per_block = cells_per_block * cells_per_block * orientations
    total_features = num_blocks_x * num_blocks_y * features_per_block
    print("[INFO] Size of HOG feature vector ...", total_features)

# Parameters
orientations = 7
pixels_per_cell = 8
cells_per_block = 4
image_shape = 128

compute_hog_feature_size(image_shape, orientations, pixels_per_cell, cells_per_block)