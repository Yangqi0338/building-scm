package com.newzkl.platform.app.scm.config;

import com.fasterxml.jackson.databind.BeanDescription;
import com.fasterxml.jackson.databind.SerializationConfig;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.ser.BeanPropertyWriter;
import com.fasterxml.jackson.databind.ser.BeanSerializerModifier;
import com.fasterxml.jackson.databind.util.NameTransformer;
import com.newzkl.platform.base.common.core.model.annotation.JsonTranslate;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;

/**
 * {@link JsonTranslate} 全局序列化装配
 *
 * <p>非侵入注册 (走 {@link Jackson2ObjectMapperBuilderCustomizer}, 不覆盖 Spring Boot 默认消息转换器)。
 * 检测到字段/getter 标 {@link JsonTranslate}, 追加同名 + "Desc" 伴生输出, 原字段保留</p>
 *
 * @author KC
 */
@Configuration
public class JsonTranslateConfig {

    /**
     * 注册 JsonTranslate 序列化修饰器到全局 ObjectMapper
     *
     * @return Jackson builder 定制器
     */
    @Bean
    public Jackson2ObjectMapperBuilderCustomizer jsonTranslateCustomizer() {
        return builder -> {
            SimpleModule module = new SimpleModule();
            module.setSerializerModifier(new TranslateSerializerModifier());
            builder.modulesToInstall(module);
        };
    }

    /**
     * JsonTranslate 字段序列化修饰器 — 标注字段追加同名 + "Desc" 伴生写出器, 原字段不变
     */
    public static class TranslateSerializerModifier extends BeanSerializerModifier {

        /**
         * {@inheritDoc}
         */
        @Override
        public List<BeanPropertyWriter> changeProperties(SerializationConfig config,
                                                         BeanDescription beanDesc,
                                                         List<BeanPropertyWriter> beanProperties) {
            List<BeanPropertyWriter> result = new ArrayList<>(beanProperties);
            for (BeanPropertyWriter writer : beanProperties) {
                JsonTranslate ann = writer.getAnnotation(JsonTranslate.class);
                if (ann == null) {
                    continue;
                }
                if (writer.getName().endsWith("Desc")) {
                    writer.assignSerializer(new JsonTranslateSerializer());
                    continue;
                }
                BeanPropertyWriter descWriter = writer.rename(
                        NameTransformer.simpleTransformer("", "Desc"));
                descWriter.assignSerializer(new JsonTranslateSerializer());
                result.add(descWriter);
            }
            return result;
        }
    }
}
