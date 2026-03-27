# catalog_lab

A Flutter product catalog application displaying products in a grid layout.

## Widget Tree

```
CatalogApp (StatelessWidget)
└── MaterialApp
    └── CatalogScreen (StatelessWidget)
        └── Scaffold
            ├── AppBar
            │   └── Text ('Catalog')
            └── Padding
                └── GridView.builder
                    └── Card (for each product)
                        └── InkWell
                            └── Column
                                ├── Expanded
                                │   └── Image.network
                                └── Padding
                                    └── Column
                                        ├── Text (product name)
                                        ├── SizedBox
                                        └── Text (product price)
```

## Features

- Grid layout with 3 columns
- 6 products displayed with images, names, and prices
- Tap interaction showing snackbar with product name
- Color-coded cards for each product category
