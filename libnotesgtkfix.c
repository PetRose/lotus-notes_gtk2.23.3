#include <stdio.h>
#include <gdk/gdkwindow.h>
#include <gdk/gdk.h>

#define __USE_GNU
#include <dlfcn.h>

static void (*_gdk_window_shape_combine_region)(GdkWindow *window, const GdkRegion *shape_region, gint offset_x, gint offset_y) = NULL;

void gdk_window_shape_combine_region (GdkWindow *window, const GdkRegion *shape_region, gint offset_x, gint offset_y) {
	GdkWindowObject *private;
	private = (GdkWindowObject *) window;
	
	// Save value of shaped
	unsigned int shaped = private->shaped;

	// Initialize pointer if uninitialized.
	if (_gdk_window_shape_combine_region == NULL)
		_gdk_window_shape_combine_region =  dlsym(RTLD_NEXT, "gdk_window_shape_combine_region");

	// In the real 'gdk_window_shape_combine_region' this exact condition returns without doing anything
	// So set shaped to 1 to force not returning.
	if (!private->shaped && shape_region == NULL)
		private->shaped = 1;

	// Call real 'gdk_window_shape_combine_region'
	_gdk_window_shape_combine_region(window, shape_region, offset_x, offset_y);
	
	// Restore shaped value
	private->shaped = shaped;
}
