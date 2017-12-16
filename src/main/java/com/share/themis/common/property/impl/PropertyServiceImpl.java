package com.share.themis.common.property.impl;

import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import com.share.themis.common.property.PropertyService;

import org.apache.commons.collections.ExtendedProperties;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanDefinitionStoreException;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.MessageSource;
import org.springframework.context.ResourceLoaderAware;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.util.Assert;

public class PropertyServiceImpl implements PropertyService, ApplicationContextAware, InitializingBean, DisposableBean, ResourceLoaderAware {

    private ExtendedProperties UserProperties = null;
    private ResourceLoader resourceLoader = null;
    private MessageSource messageSource;
    private Set extFileName;
    private Map properties;

    public boolean getBoolean(String name)
    {
        return getConfiguration().getBoolean(name);
    }

    public boolean getBoolean(String name, boolean def)
    {
        return getConfiguration().getBoolean(name, def);
    }

    public double getDouble(String name)
    {
        return getConfiguration().getDouble(name);
    }

    public double getDouble(String name, double def)
    {
        return getConfiguration().getDouble(name, def);
    }

    public float getFloat(String name)
    {
        return getConfiguration().getFloat(name);
    }

    public float getFloat(String name, float def)
    {
        return getConfiguration().getFloat(name, def);
    }

    public int getInt(String name)
    {
        return getConfiguration().getInt(name);
    }

    public int getInt(String name, int def)
    {
        return getConfiguration().getInt(name, def);
    }

    public Iterator getKeys()
    {
        return getConfiguration().getKeys();
    }

    public Iterator getKeys(String prefix)
    {
        return getConfiguration().getKeys(prefix);
    }

    public long getLong(String name)
    {
        return getConfiguration().getLong(name);
    }

    public long getLong(String name, long def)
    {
        return getConfiguration().getLong(name, def);
    }

    public String getString(String name)
    {
        return getConfiguration().getString(name);
    }

    public String getString(String name, String def)
    {
        return getConfiguration().getString(name, def);
    }

    public String[] getStringArray(String name)
    {
        return getConfiguration().getStringArray(name);
    }

    public Vector getVector(String name)
    {
        return getConfiguration().getVector(name);
    }

    public Vector getVector(String name, Vector def)
    {
        return getConfiguration().getVector(name, def);
    }

    public Collection getAllKeyValue()
    {
        return getConfiguration().values();
    }

    private ExtendedProperties getConfiguration()
    {
        return this.UserProperties;
    }

    public void refreshPropertyFiles()
        throws Exception
    {
        String fileName = null;

            Iterator it = this.extFileName.iterator();

            do {
                Object element = it.next();
                String enc = null;

                if (element instanceof Map) {
                    Map ele = (Map)element;
                    enc = (String)ele.get("encoding");
                    fileName = (String)ele.get("filename");
                }
                else {
                    fileName = (String)element;
                }
                loadPropertyResources(fileName, enc);

                if (it == null) label80: return;    }
            while (it.hasNext());
    }

    public void afterPropertiesSet()
        throws Exception
    {

            this.UserProperties = new ExtendedProperties();

            if (this.extFileName != null) {
                refreshPropertyFiles();
            }

            Iterator it = this.properties.entrySet().iterator();
            while (it.hasNext())
            {
                Map.Entry entry = (Map.Entry)it.next();
                String key = (String)entry.getKey();
                String value = (String)entry.getValue();

                if (key != null && !"".equals(key))
                    this.UserProperties.put(key, value);
            }

    }

    public void setExtFileName(Set extFileName)
    {
        this.extFileName = extFileName;
    }

    public void setProperties(Map properties)
    {
        this.properties = properties;
    }

    public void destroy()
    {
        this.UserProperties = null;
    }

    public void setResourceLoader(ResourceLoader resourceLoader)
    {
        this.resourceLoader = resourceLoader;
    }

    public void setApplicationContext(ApplicationContext applicationContext)
        throws BeansException
    {
        this.messageSource = ((MessageSource)
            applicationContext.getBean("messageSource"));
    }

    private void loadPropertyResources(String location, String encoding)
        throws Exception
    {
        if (this.resourceLoader instanceof ResourcePatternResolver) {
            try {
                Resource[] resources = ((ResourcePatternResolver)this.resourceLoader)
                    .getResources(location);

                loadPropertyLoop(resources, encoding);
            } catch (IOException ex) {
                throw new BeanDefinitionStoreException(
                    "Could not resolve Properties resource pattern [" + 
                    location + "]", ex);
            }
        }
        else {
            Resource resource = this.resourceLoader.getResource(location);
            loadPropertyRes(resource, encoding);
        }
    }

    private void loadPropertyLoop(Resource[] resources, String encoding)
        throws Exception
    {
        Assert.notNull(resources, "Resource array must not be null");
        for (int i = 0; i < resources.length; ++i)
            loadPropertyRes(resources[i], encoding);
    }

    private void loadPropertyRes(Resource resource, String encoding)
        throws Exception
    {
        ExtendedProperties Property = new ExtendedProperties();
        Property.load(resource.getInputStream(), encoding);
        this.UserProperties.combine(Property);
    }

}
