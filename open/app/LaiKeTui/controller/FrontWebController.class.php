<?php

// +---------------------------------------------------------------------------+
// | This file is part of the core package.                                    |
// | Copyright (c) laiketui.com                                                |
// |                                                                           |
// | For the full copyright and license information, please view the LICENSE   |
// | file that was distributed with this source code. You can also view the    |
// | LICENSE file online at http://www.laiketui.com                            |
// +---------------------------------------------------------------------------+

/**
 * FrontWebController allows you to centralize your entry point in your web
 * application, but at the same time allow for any module and action combination
 * to be requested.
 *
 * @package    laiketui
 * @subpackage controller
 *
 * @author ketter (ketter@laiketui.com)
 * @since  3.0.0
 */
class FrontWebController extends WebController
{

    // +-----------------------------------------------------------------------+
    // | METHODS                                                               |
    // +-----------------------------------------------------------------------+

    /**
     * Dispatch a request.
     *
     * This will determine which module and action to use by request parameters
     * specified by the user.
     *
     * @return void
     *
     * @author ketter (ketter@laiketui.com)
     * @since  3.0.0
     */
    public function dispatch ()
    {

        try
        {

            // initialize the controller
            $this->initialize();

            // get the application context
            $context = $this->getContext();

            // determine our module and action
            $moduleName = $context->getRequest()
                                  ->getParameter(MO_MODULE_ACCESSOR);
			

            $actionName = $context->getRequest()
                                  ->getParameter(MO_ACTION_ACCESSOR);

            if ($moduleName == null)
            {

                // no module has been specified
                $moduleName = MO_DEFAULT_MODULE;

            }

            if ($actionName == null)
            {

                // no action has been specified
                if ($this->actionExists($moduleName, 'Index'))
                {

                    // an Index action exists
                    $actionName = 'Index';

                } else
                {

                    // use the default action
                    $actionName = MO_DEFAULT_ACTION;

                }

            }

            // make the first request
            $this->forward($moduleName, $actionName);

        } catch (MojaviException $e)
        {

            $e->printStackTrace();

        } catch (Exception $e)
        {

            // most likely an exception from a third-party library
            $e = new MojaviException($e->getMessage());

            $e->printStackTrace();

        }

    }

}

?>