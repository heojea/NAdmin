package com.share.themis.common.property.impl;

import java.net.URL;
import java.util.List;
import java.util.Properties;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationFactory;
import org.apache.commons.configuration.FileConfiguration;
import org.apache.commons.configuration.reloading.FileChangedReloadingStrategy;

import com.share.themis.common.property.ConfigurationService;

public class ConfigurationReader implements ConfigurationService {
    private Configuration configuration;
    private String configLocation;
    private String reloadable;

    public String getConfigLocation() {
        return this.configLocation;
    }

    public void setConfigLocation(String configLocation) {
        this.configLocation = configLocation;
    }

    public String getReloadable() {
        return this.reloadable;
    }

    public void setReloadable(String reloadable) {
        this.reloadable = reloadable;
    }

    public void loadConfiguration(String configPath, String reloadable) {
        ConfigurationFactory factory = new ConfigurationFactory();
            
        URL url = ConfigurationReader.class.getResource(configPath);
            
        if (url != null)
              factory.setConfigurationURL(url);
        else
              factory.setConfigurationFileName(configPath);
        try {
              this.configuration = factory.getConfiguration();
        }
        catch (Exception localConfigurationException) {}
            
        if ("true".equalsIgnoreCase(reloadable))
        setReload(this.configuration);
    }

    private static void setReload(Configuration config) {
        if (config instanceof CompositeConfiguration) {
            CompositeConfiguration cc = (CompositeConfiguration)config;
            for (int i = 0; i < cc.getNumberOfConfigurations(); ++i) {
                if (!(cc.getConfiguration(i) instanceof FileConfiguration)) continue;
                ((FileConfiguration)cc.getConfiguration(i))
                    .setReloadingStrategy(new FileChangedReloadingStrategy()); }
        }
    }

    private void initialize() {
        if (this.configuration == null)
            loadConfiguration(getConfigLocation(), getReloadable());
    }

    public String getString(String param) {
        initialize();
        return this.configuration.getString(param);
    }

    public int getInt(String param) {
        initialize();
        return this.configuration.getInt(param);
    }

    public String[] getStringArray(String param) {
        initialize();
        return this.configuration.getStringArray(param);
    }

    public Properties getProperties(String param) {
        initialize();
        return this.configuration.getProperties(param);
    }

    public List getList(String param) {
        initialize();
        return this.configuration.getList(param);
    }
}
