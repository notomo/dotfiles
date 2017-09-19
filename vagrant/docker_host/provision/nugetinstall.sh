#!/bin/sh
nuget install "$* -OutputDirectory packages -ExcludeVersion"
